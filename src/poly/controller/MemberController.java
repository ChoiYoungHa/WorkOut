package poly.controller;

import org.springframework.stereotype.Controller;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.MailDTO;
import poly.dto.MemberDTO;
import poly.service.IMailService;
import poly.service.IMemberService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;
import poly.util.TemporaryMail;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class MemberController {

    @Resource(name = "MailService")
    private IMailService mailService;

    @Resource(name = "MemberService")
    private IMemberService memberService;

    private Logger log = Logger.getLogger(this.getClass());

    //로그인 화면
    @RequestMapping(value = "logIn")
    public String logIn() {
        log.info(this.getClass().getName() + ".login 시작!");
        return "/user/logIn";
    }

    //로그인 진행
    @RequestMapping(value = "/getLogin", method = RequestMethod.POST)
    public String getLogin(HttpServletRequest request, HttpSession session,
                           ModelMap model) throws Exception {
        log.info("getLogin Start!");

        // 이메일은 복호화가 가능한 AES128, 비밀번호는 복호화 불가능한 HASH256 사용
        String email = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("email")));
        String password = CmmUtil.nvl(EncryptUtil.encHashSHA256(request.getParameter("password")));

        log.info("String user_email : " + EncryptUtil.decAES128CBC(email));
        log.info("String password : " + password);

        MemberDTO pDTO = new MemberDTO();

        log.info("pDTO.set 시작");
        pDTO.setEmail(email);
        pDTO.setMember_pw(password);

        log.info("pDTO.email : " + pDTO.getEmail());
        log.info("pDTO.password : " + pDTO.getMember_pw());

        log.info("userService.getLogin 시작");
        MemberDTO rDTO = memberService.getLogin(pDTO);

        pDTO = null;
        log.info("rDTO null? " + (rDTO == null));

        String msg = "";
        String url = "";

        // 로그인에 실패한 경우
        if (rDTO == null) {
            msg = "로그인에 실패했습니다. 다시 시도해 주세요.";
            url = "/logIn.do"; //재 로그인
        }
        // 로그인 성공한 경우(rDTO != null)
        else {
            log.info("rDTO.getEmail : " + rDTO.getEmail());
            log.info("rDTO.getMember_name: " + rDTO.getMember_name());
            log.info("rDTO.getMember_id : " + rDTO.getMember_id());
            msg = "환영합니다!";

            // 회원 번호로 세션 올림, "ㅇㅇㅇ님, 환영합니다" 같은 문구 표시를 위해 user_name도 세션에 올림
            session.setAttribute("SS_MEMBER_ID", rDTO.getMember_id());
            session.setAttribute("SS_MEMBER_NAME", rDTO.getMember_name());
            log.info("session.setAttribute 완료");


            log.info("model.addAttribute 시작!");
            model.addAttribute("member_nic", rDTO.getMember_nic());
            log.info("model.addAttribute 끝!");

            url = "/index.do"; //로그인 성공 후 리턴할 페이지
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);
        log.info("msg : " + msg);
        log.info("url : " + url);

        rDTO = null;
        log.info("rDTO null? : " + (rDTO == null));
        log.info("getLogin end");

        return "/redirect";
    }

    // 로그아웃
    @RequestMapping(value = "logOut")
    public String logOut(HttpSession session, ModelMap model) throws Exception {
        log.info("logOut Start!");

        String msg = "로그아웃 되었습니다.";
        String url = "/index.do";

        // 세션 삭제(user_name, user_no) - invalidate() 또는 removeAttribute 함수 사용
        session.removeAttribute("SS_MEMBER_ID");
        session.removeAttribute("SS_MEMBER_NO");

        // 세션이 정상적으로 삭제되었는지 로그를 통해 확인
        log.info("session deleted ? : " + session.getAttribute("SS_MEMBER_ID"));
        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info("session delete, model.addAttribute 끝!");
        log.info("logOut End!");

        return "/redirect";
    }

    //회원가입 화면
    @RequestMapping(value = "signup")
    public String SignUp(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        log.info(this.getClass().getName() + ".signup 시작!");
        return "/user/signUp";
    }

    //회원가입 화면
    @RequestMapping(value = "find_pw")
    public String find_pw() {
        log.info(this.getClass().getName() + ".signup 시작!");
        return "/user/find_pw_email";
    }


    //회원가입 진행
    @RequestMapping(value = "/insertMember", method = RequestMethod.POST)
    public String insertMember(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info("insertMember Start!");

        // 회원가입 jsp 에서 입력받은 값 가져오기
        // 민감 정보인 이메일은 AES128-CBC로 암호화함
        String email = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("email")));
        // 비밀번호는 복호화되지 않도록 HASHSHA256 단일 알고리즘으로 암호화함
        String password = CmmUtil.nvl(EncryptUtil.encHashSHA256(request.getParameter("password")));
        String member_name = CmmUtil.nvl(request.getParameter("member_name"));
        String member_nic = CmmUtil.nvl(request.getParameter("member_nic"));

        MemberDTO pDTO = new MemberDTO();

        log.info("pDTO 세팅 시작");

        // jsp에서 가져온 값을 DTO에 저장
        pDTO.setEmail(email);
        pDTO.setMember_name(member_name);
        pDTO.setMember_nic(member_nic);
        pDTO.setMember_pw(password);


        // 회원정보가 제대로 전달되었는지 로그를 통해 확인
        log.info("user_email : " + email);
        log.info("member_name : " + member_name);
        log.info("member_nic : " + member_nic);
        log.info("password : " + password);
        log.info("pDTO 세팅 끝");

        log.info("res 시작");
        // DB에 값이 잘 저장되었다면, 1 반환
        int res = memberService.insertMember(pDTO);
        log.info("res : " + res);

        String msg = "";
        String url = "";

        if (res > 0) {
            // 회원가입이 완료되었다면, 이메일 발송
            log.info("회원가입 이메일 발송 시작");

            MailDTO mDTO = new MailDTO();

            // 발송할 이메일을 복호화하여 가져옴
            mDTO.setToMail(EncryptUtil.decAES128CBC(CmmUtil.nvl(pDTO.getEmail())));
            mDTO.setTitle("Work Out 회원가입을 축하드립니다.");
            mDTO.setContents(CmmUtil.nvl(pDTO.getMember_name()) + "님의 회원가입을 축하드립니다.");

            // mDTO에 세팅한 내용으로, 메일 발송
            mailService.doSendMail(mDTO);
            mDTO = null;
            log.info("회원가입 이메일 발송 완료");

            if (res > 0) {
                msg = "회원가입을 축하드립니다.";
            } else {
                msg = "회원정보를 확인 후 가입을 진행해 주세요.";
            }

        } else {
            msg = "회원정보를 확인 후 가입을 진행해 주세요.";
        }

        url = "/index.do";
        log.info("model.addAttribute");
        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        pDTO = null;
        log.info("insertUser End!");
        return "/redirect";
    }

    /* 이메일 중복 확인
     * @ResponseBody 사용으로, http에 값(res) 전달 */
    @ResponseBody
    @RequestMapping(value = "/signup/emailCheck", method = RequestMethod.POST)
    public int emailCheck(HttpServletRequest request) throws Exception {
        log.info("Email check Start");

        String email = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("email")));
        log.info("email : " + email);

        log.info("userService.emailCheck Start!");
        MemberDTO pDTO = memberService.emailCheck(email);

        log.info("pDTO : " + pDTO);
        log.info("userService.emailCheck End!");

        int res = 0;

        // 값이 있다면, res = 1
        if (pDTO != null) {
            res = 1;
        }

        pDTO = null;

        log.info("res : " + res);
        log.info("Email Check End!");

        return res;
    }

    // 비밀번호찾기 인증번호 발송 로직
    @RequestMapping(value = "find_pw_email")
    public String find_pw_email(HttpServletRequest request, ModelMap model, HttpSession session)
            throws InvalidAlgorithmParameterException, UnsupportedEncodingException, NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, BadPaddingException, InvalidKeyException {
        log.info("####################################################");
        log.info("인증번호 발송 START!!");

        String email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("email")));
        session.setAttribute("SS_EMAIL", email);

        String auth = "";
        String msg = "";
        String url = "";

        // 랜덤한 8자 인증번호값 담기
        auth = TemporaryMail.SendTemporaryMail();

        // 인증번호
        log.info("인증번호 : " + auth);
        MailDTO mDTO = new MailDTO();

        try {
            // 이메일 보내기 위해 다시 암호화 디코딩
            email = EncryptUtil.decAES128CBC(email);
            log.info("이메일 : " + email);

            // 인증번호 메일 발송 로직
            mDTO.setToMail(email);
            mDTO.setTitle("Work out 인증번호 이메일입니다.");
            mDTO.setContents("임시 비밀번호는 :  " + auth + "  입니다.");

            // 최종 전송
            mailService.doSendMail(mDTO);

            msg = "이메일로 인증번호를 발송하였습니다.";

            model.addAttribute("msg", msg);
            session.setAttribute("SS_AUTH", auth);

            // 변수와 메모리 초기화
            msg = "";
            url = "";
            mDTO = null;

            log.info("인증번호 발송 END!!");

            return "/user/find_pw_check";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.toString();
            url = "/";
            log.info(e.toString());
            e.printStackTrace();

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);

        } finally {
            // 변수와 메모리 초기화
            msg = "";
            url = "";
            mDTO = null;
        }


        log.info("####################################################");
        log.info("인증번호 발송 END!!");

        return "/redirect";
    }


    // 비밀번호 변경 인증번호 검사
    @RequestMapping(value = "find_pw_result", method = RequestMethod.POST)
    public String find_pw_result(HttpServletRequest request, HttpSession session, ModelMap model){
        log.info("find_pw_result Start!");
        String client_auth = CmmUtil.nvl(request.getParameter("client_auth"));
        String auth = CmmUtil.nvl((String) session.getAttribute("SS_AUTH"));

        log.info("client_auth : " + client_auth);
        log.info("auth : " + auth);

        String msg = "";
        String url = "";

        // 이메일 인증번호와 사용자가 입력한 인증번호 비교
        if(client_auth.equals(auth)){
            url = "find_pw_change.do";
            msg = "인증에 성공하였습니다.";
        }
        else {
            url = "/index.do";
            msg = "인증번호가 틀립니다.";
        }
        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        // 인증완료 후 세션 비워주기
        session.removeAttribute("SS_AUTH");
        log.info("session deleted ? : " + session.getAttribute("SS_AUTH"));

        return "redirect";
    }

    // 비밀번호 변경 페이지로 연결
    @RequestMapping(value = "find_pw_change")
    public String find_pw_change(){
        return "/user/find_pw_update";
    }

    // 비밀번호 변경 로직 수행
    @RequestMapping(value = "find_pw_change_update")
    public String find_pw_change_update(HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
        log.info("find_pw_change_update start!");
        String email = CmmUtil.nvl((String) session.getAttribute("SS_EMAIL"));
        String member_pw = CmmUtil.nvl(EncryptUtil.encHashSHA256(request.getParameter("password1")));

        log.info("email : " + email);
        log.info("member_pw : " + member_pw);

        String msg = "";
        String url = "";

        MemberDTO pDTO = null;

        try {
            pDTO = new MemberDTO();

            //where에 email을 사용, 수정할 비밀번호 전달
            pDTO.setEmail(email);
            pDTO.setMember_pw(member_pw);

            // 비밀번호 DB반영
            memberService.update_pw(pDTO);

            msg = "비밀번호가 변경되었습니다.";
            url = "/index.do";

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);

            // 변수와 메모리 초기화
            msg = "";
            url = "";
            pDTO = null;
            log.info("비밀번호 변경 종료");

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.toString();
            url = "/";
            log.info(e.toString());
            e.printStackTrace();

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);

        } finally {
            // 변수와 메모리 초기화
            msg = "";
            url = "";
            pDTO = null;
        }

        // 세션 비워주기
        session.removeAttribute("SS_EMAIL");
        log.info("session deleted ? : " + session.getAttribute("SS_EMAIL"));

        log.info("find_pw_change_update End!");
        return "/redirect";
    }
}
