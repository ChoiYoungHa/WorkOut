package poly.controller;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import poly.dto.NoticeDTO;
import poly.service.INoticeService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class NoticeController {
    @Resource(name = "NoticeService")
    private INoticeService noticeService;

    private Logger log = Logger.getLogger(this.getClass());


    /**
     * 게시판 글 등록
     * */
    @RequestMapping(value="notice/NoticeInsert", method= RequestMethod.POST)
    public String NoticeInsert(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                               ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".NoticeInsert start!");

        String msg = "";

        try{
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             * */
            int member_id = (int) CmmUtil.nvl(session.getAttribute("SS_MEMBER_NAME")); // 회원번호
            String post_title = CmmUtil.nvl(request.getParameter("title")); //제목
            String post_category = CmmUtil.nvl(request.getParameter("category")); //카테고리
            String content = CmmUtil.nvl(request.getParameter("contents")); //내용

            /*
             * #######################################################
             * 	 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함
             * 						반드시 작성할 것
             * #######################################################
             * */
            log.info("member_id : "+ member_id);
            log.info("post_title : "+ post_title);
            log.info("post_category : "+ post_category);
            log.info("content : "+ content);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setMember_id(member_id);
            pDTO.setPost_title(post_title);
            pDTO.setPost_category(post_category);
            pDTO.setContent(content);


            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             * */
            noticeService.InsertNoticeInfo(pDTO);
            noticeService.ContentNotice(pDTO);


            //저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


            //변수 초기화(메모리 효율화 시키기 위해 사용함)
            pDTO = null;

        }catch(Exception e){

            //저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : "+ e.toString();
            log.info(e.toString());
            e.printStackTrace();

        }finally{

            log.info(this.getClass().getName() + ".NoticeInsert end!");
            //결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }
        return "/notice/MsgToList";
    }


}
