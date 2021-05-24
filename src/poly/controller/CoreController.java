package poly.controller;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.MemberDTO;
import poly.service.ICoreService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class CoreController {
    @Resource(name = "CoreService")
    private ICoreService coreService;

    private Logger log = Logger.getLogger(this.getClass());

    // 기초대사량 체크
    @RequestMapping(value = "/checkMemberGk")
    public String checkMemberGk(HttpSession session, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".checkMemberGk Start!");

        String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));
        log.info("member_id : " + member_id);

        MemberDTO pDTO = new MemberDTO();
        pDTO.setMember_id(member_id);

        String msg = "";
        String url = "";

        MemberDTO rDTO = coreService.checkMemberGK(pDTO);

        if(rDTO == null){
            rDTO = new MemberDTO();
        }

        String res = CmmUtil.nvl(rDTO.getMember_gk(), "0");
        log.info("res : " + res);

        if (res.equals("0")) {
            url = "/metabolism.do";
            msg = "기초대사량을 구해주세요.";
        }else {
            url = "/menu.do";
            msg = "환영합니다.";
            session.setAttribute("SS_MEMBER_GK",res);
        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".checkMemberGk End!");
        return "/redirect";
    }

    // 기초대사량 구하는 페이지 연결
    @RequestMapping(value = "/metabolism")
    public String metabolism() {
        return "/menu/metabolism";
    }

    @RequestMapping(value = "/MetabolismResult")
    public String MetabolismResult(HttpServletRequest request, HttpSession session, ModelMap model){
        log.info(this.getClass().getName() + "MetabolismResult. Start!");

        String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));
        String goal_kcal = CmmUtil.nvl(request.getParameter("goal_kcal"));

        log.info("member_id : " + member_id);
        log.info("goal_kcal : " + goal_kcal);

        double member_gk = Math.ceil(Double.parseDouble(goal_kcal));
        log.info("member_gk : " + member_gk);
        int res = (int) member_gk;
        log.info("res : " + res);

        String result = String.valueOf(res);


        MemberDTO pDTO = new MemberDTO();
        pDTO.setMember_gk(goal_kcal);
        pDTO.setMember_id(member_id);

        String msg = "";
        String url = "";

        try{
            coreService.insertGk(pDTO);
            msg = "등록에 성공했습니다.";
            url = "/menu.do";
            session.setAttribute("SS_MEMBER_GK",result);

        } catch (Exception e) {
            e.printStackTrace();
            msg = "등록에 실패했습니다.";
            url = "/metabolism.do";
        }finally {
            // 메모리 비워주기
            pDTO = null;
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + "MetabolismResult. END!");
        return "/redirect";
    }
}
