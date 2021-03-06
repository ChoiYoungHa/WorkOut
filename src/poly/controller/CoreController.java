package poly.controller;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.FoodDTO;
import poly.dto.MemberDTO;
import poly.service.ICoreService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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


    // 기초대사량 등록
    @RequestMapping(value = "/MetabolismResult")
    public String MetabolismResult(HttpServletRequest request, HttpSession session, ModelMap model){
        log.info(this.getClass().getName() + "MetabolismResult. Start!");

        // 세션값, 목표칼로리 프론트에서 받기
        String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));
        String goal_kcal = CmmUtil.nvl(request.getParameter("goal_kcal"));

        log.info("member_id : " + member_id);
        log.info("goal_kcal : " + goal_kcal);


        // 소수점 반올림
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

        // 목표칼로리 저장
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

    /**
     * API 에서 받아온 식단 리스트 저장
     */
    @RequestMapping(value = "/insertFood")
    @ResponseBody
    public FoodDTO insertFood(HttpServletRequest request, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + "insertFood. Start!");

        // api 정보 받아오기
        String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));
        String food_time = CmmUtil.nvl(request.getParameter("food_time")); // 섭취 시간
        String food_name = CmmUtil.nvl(request.getParameter("food_name")); // 음식 이름
        String food_brand = CmmUtil.nvl(request.getParameter("food_brand")); // 음식 제조사
        String food_gram = CmmUtil.nvl(request.getParameter("food_gram")); // 음식 량
        String food_kcal = CmmUtil.nvl(request.getParameter("food_kcal")); // 음식 칼로리
        String tan = CmmUtil.nvl(request.getParameter("tan"), "0"); // 탄수화물
        String dan = CmmUtil.nvl(request.getParameter("dan"), "0"); // 단백질
        String fat = CmmUtil.nvl(request.getParameter("fat"), "0"); // 지방
        String amount = CmmUtil.nvl(request.getParameter("amount")); // 수량

        // 데이터 값 확인
        log.info("member_id : " + member_id);
        log.info("food_time : " + food_time);
        log.info("food_name : " + food_name);
        log.info("food_brand : " + food_brand);
        log.info("food_gram : " + food_gram);
        log.info("food_kcal : " + food_kcal);
        log.info("tan : " + tan);
        log.info("dan : " + dan);
        log.info("fat : " + fat);
        log.info("amount : " + amount);

        // 저장할 데이터 세팅
        FoodDTO pDTO = new FoodDTO();
        pDTO.setMember_id(member_id);
        pDTO.setFood_time(food_time);
        pDTO.setFood_name(food_name);
        pDTO.setFood_brand(food_brand);
        pDTO.setFood_gram(food_gram);
        pDTO.setFood_kcal(food_kcal);
        pDTO.setTan(tan);
        pDTO.setDan(dan);
        pDTO.setFat(fat);
        pDTO.setAmount(amount);

        try{
            coreService.insertFood(pDTO);
        }catch (Exception e){
            log.info(e.toString());
            e.printStackTrace();
        }

        log.info(this.getClass().getName() + "insertFood. END!");
        return pDTO;
    }


    // 각 회원이 등록한 음식리스트 가져오기
    @RequestMapping(value = "/getFoodData")
    @ResponseBody
    public List<FoodDTO> getFoodData(HttpServletRequest request,HttpSession session) throws Exception {
        log.info(this.getClass().getName() + "getFoodData. Start!");

        String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));

        FoodDTO pDTO = new FoodDTO();
        pDTO.setMember_id(member_id);


        // 회원이 등록한 음식 리스트 가져오기
        List<FoodDTO> rList = coreService.find_FoodData(pDTO);

        if (rList == null) {
            rList = new ArrayList<>();
        }

        log.info(this.getClass().getName() + "getFoodData. END!");

        return rList;
    }

    // 음식 삭제
    @RequestMapping(value = "/deleteFoodData")
    @ResponseBody
    public int deleteFoodData(HttpServletRequest request, HttpSession session){
        log.info(this.getClass().getName() + "deleteFoodData. Start!");
        String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID"));
        String food_time = CmmUtil.nvl(request.getParameter("food_time"));
        String food_kcal = CmmUtil.nvl(request.getParameter("food_kcal"));
        String food_gram = CmmUtil.nvl(request.getParameter("food_gram"));

        log.info("member_id : " + member_id);
        log.info("food_time : " + food_time);
        log.info("food_kcal : " + food_kcal);
        log.info("food_gram : " + food_gram);

        FoodDTO pDTO = new FoodDTO();

        pDTO.setMember_id(member_id);
        pDTO.setFood_time(food_time);
        pDTO.setFood_kcal(food_kcal);
        pDTO.setFood_gram(food_gram);

        int res = 0;

        try{
            coreService.deleteFood(pDTO);
            log.info("성공!");
            res = 1;

        }catch (Exception e){
            log.info(e.toString());
            e.printStackTrace();
            log.info("실패");
        }finally {
            pDTO = null;
        }

        log.info(this.getClass().getName() + "deleteFoodData. END!");
        return res;
    }

    @RequestMapping(value = "/workMain")
    public String work_main(){
        return "/work/workMain";
    }


}
