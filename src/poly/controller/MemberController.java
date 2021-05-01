package poly.controller;

import org.springframework.stereotype.Controller;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.MailDTO;
import poly.dto.MemberDTO;
import poly.service.IMailService;
import poly.service.IMemberService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class MemberController {

    @Resource(name="MailService")
    private IMailService mailService;

    @Resource(name="MemberService")
    private IMemberService memberService;

    private Logger log = Logger.getLogger(this.getClass());

    //로그인 화면
    @RequestMapping(value="logIn")
    public String logIn() {
        log.info(this.getClass().getName() + ".login 시작!");
        return "/user/logIn";
    }

    //로그인 진행
    @RequestMapping(value="/getLogin", method = RequestMethod.POST)
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
    @RequestMapping(value="logOut")
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
    @RequestMapping(value="signup")
    public String SignUp(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        log.info(this.getClass().getName() + ".signup 시작!");
        return "/user/signUp";
    }

    //회원가입 진행
    @RequestMapping(value="/insertMember", method= RequestMethod.POST)
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
                msg =  "회원정보를 확인 후 가입을 진행해 주세요.";
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
    @RequestMapping(value="/signup/emailCheck", method=RequestMethod.POST)
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
}
