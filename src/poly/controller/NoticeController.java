package poly.controller;
import org.apache.commons.collections.ArrayStack;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.MemberDTO;
import poly.dto.NoticeDTO;
import poly.service.IMemberService;
import poly.service.INoticeService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
public class NoticeController {
    @Resource(name = "NoticeService")
    private INoticeService noticeService;

    @Resource(name = "MemberService")
    private IMemberService memberService;

    private Logger log = Logger.getLogger(this.getClass());

    /**
     * 게시글 작성 페이지 이동
     */
    @RequestMapping(value = "notice/insertPage")
    public String insertPage() {
        log.info(this.getClass().getName() + ".insertPage Start!");
        log.info(this.getClass().getName() + ".insertPage END!");
        return "/notice/NoticeReg";
    }


    /**
     * 게시판 글 등록
     */
    @RequestMapping(value = "notice/NoticeInsert", method = RequestMethod.POST)
    public String NoticeInsert(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                               ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".NoticeInsert start!");

        String msg = "";

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             * */
            String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID")); // 회원번호
            String post_title = CmmUtil.nvl(request.getParameter("title")); //제목
            String post_category = CmmUtil.nvl(request.getParameter("category")); //카테고리
            String content = CmmUtil.nvl(request.getParameter("contents")); //내용

            /*
             * #######################################################
             * 	 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함
             * 						반드시 작성할 것
             * #######################################################
             * */
            log.info("member_id : " + member_id);
            log.info("post_title : " + post_title);
            log.info("post_category : " + post_category);
            log.info("content : " + content);

            NoticeDTO pDTO = new NoticeDTO();

            // 게시판 분류 리다이렉트
            model.addAttribute("post_category", post_category);

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

        } catch (Exception e) {

            //저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.toString();
            log.info(e.toString());
            e.printStackTrace();

        } finally {

            log.info(this.getClass().getName() + ".NoticeInsert end!");
            //결과 메시지 전달 하기
            model.addAttribute("msg", msg);

        }
        return "/notice/MsgToList";
    }

    /**
     * 게시판 리스트 보여주기_분리 운동게시판, 식단 게시판
     */
    @RequestMapping(value = "notice/NoticeListCategory", method = RequestMethod.GET)
    public String NoticeListWork(HttpServletRequest request, ModelMap model) throws Exception {

        //로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeListCategory start!");

        // 카테고리 받아오기
        String post_category = CmmUtil.nvl(request.getParameter("category")); //카테고리
        log.info("post_category : " + post_category);

        NoticeDTO rDTO = new NoticeDTO();
        rDTO.setPost_category(post_category);

        //카테고리별 게시판 리스트 가져오기
        List<NoticeDTO> rList = noticeService.getNoticeList_Category(rDTO);

        if (rList == null) {
            rList = new ArrayList<NoticeDTO>();
        }

        //조회된 리스트 결과값 넣어주기
        model.addAttribute("post_category", post_category);
        model.addAttribute("rList", rList);

        //변수 초기화(메모리 효율화 시키기 위해 사용함)
        rList = null;

        //로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeListCategory end!");

        //함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/notice/NoticeList";
    }

    /**
     * 게시판 상세보기
     */
    @RequestMapping(value = "notice/NoticeInfo", method = RequestMethod.GET)
    public String NoticeInfo(HttpServletRequest request, HttpServletResponse response,
                             ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".NoticeInfo start!");


        /*
         * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
         * */
        String nSeq = CmmUtil.nvl(request.getParameter("nSeq"));

        // 게시글번호
        log.info("nSeq : " + nSeq);

        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setPost_id(nSeq);

        // 게시글 조회수 증가
        noticeService.updateNoticeReadCnt(pDTO);
        log.info("read_cnt update success!!!");

        // 게시글 상세정보 가져오기
        NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);
        log.info("rDTO.getPost_title()" + rDTO.getPost_title());
        log.info("rDTO.getContent()  :" + rDTO.getContent());
        log.info("rDTO.getPost_category() : " + rDTO.getPost_category());
        log.info("rDTO.getMember_member_id() : " + rDTO.getMember_member_id()); // 작성자 회원 ID


        // 게시글 작성자를 조회하기 위해 ID 세팅
        String member_id = rDTO.getMember_member_id();
        MemberDTO fDTO = new MemberDTO();
        fDTO.setMember_id(member_id);

        // 회원정보 가져오기
        MemberDTO find_member = memberService.member_find(fDTO);
        log.info("find_member.getMember_nic() : " + find_member.getMember_nic());

        if (rDTO == null) {
            rDTO = new NoticeDTO();
        }
        log.info("getNoticeInfo success!!!");

        //조회된 리스트 결과값 넣어주기
        model.addAttribute("rDTO", rDTO);
        model.addAttribute("find_member", find_member);

        //변수 초기화(메모리 효율화 시키기 위해 사용함)
        rDTO = null;
        pDTO = null;
        fDTO = null;

        log.info(this.getClass().getName() + ".NoticeInfo end!");

        return "/notice/NoticeInfo";
    }

    /**
     * 게시판 수정 보기
     */
    @RequestMapping(value = "notice/NoticeEditInfo", method = RequestMethod.GET)
    public String NoticeEditInfo(HttpServletRequest request, HttpServletResponse response,
                                 ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".NoticeEditInfo start!");
        String post_id = CmmUtil.nvl(request.getParameter("nSeq")); // 게시글번호

        log.info("post_id : " + post_id);

        NoticeDTO pDTO = new NoticeDTO();

        pDTO.setPost_id(post_id);
        ;

        /*
         * #######################################################
         * 	수정정보 가져오기(상세보기 쿼리와 동일하여, 같은 서비스 쿼리 사용함)
         * #######################################################
         */
        NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);

        if (rDTO == null) {
            rDTO = new NoticeDTO();
        }

        //조회된 리스트 결과값 넣어주기
        model.addAttribute("rDTO", rDTO);

        //변수 초기화(메모리 효율화 시키기 위해 사용함)
        rDTO = null;
        pDTO = null;

        log.info(this.getClass().getName() + ".NoticeEditInfo end!");

        return "/notice/NoticeEditInfo";
    }

    /**
     * 게시판 글 수정
     */
    @RequestMapping(value = "notice/NoticeUpdate", method = RequestMethod.POST)
    public String NoticeUpdate(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                               ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".NoticeUpdate start!");

        String msg = "";

        try {
            String member_id = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_ID")); //아이디
            String post_id = CmmUtil.nvl(request.getParameter("nSeq")); //글번호(PK)
            String post_title = CmmUtil.nvl(request.getParameter("title")); //제목
            String post_category = CmmUtil.nvl(request.getParameter("category")); // 카테고리
            String content = CmmUtil.nvl(request.getParameter("contents")); //내용


            log.info("post_id : " + post_id);
            log.info("post_title : " + post_title);
            log.info("post_category : " + post_category);
            log.info("content : " + content);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setPost_id(post_id);
            pDTO.setPost_title(post_title);
            pDTO.setPost_category(post_category);
            pDTO.setContent(content);

            //게시글 수정하기 DB
            noticeService.updateNoticeInfo(pDTO);

            msg = "수정되었습니다.";

            //변수 초기화(메모리 효율화 시키기 위해 사용함)
            pDTO = null;

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.toString();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeUpdate end!");

            //결과 메시지 전달하기
            model.addAttribute("msg", msg);
        }
        return "/notice/MsgToList";
    }


    /**
     * 게시판 글 삭제
     */
    @RequestMapping(value = "notice/NoticeDelete", method = RequestMethod.GET)
    public String NoticeDelete(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                               ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".NoticeDelete start!");

        String msg = "";

        try {
            String post_id = CmmUtil.nvl(request.getParameter("nSeq")); //글번호(PK)

            log.info("post_id : " + post_id);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setPost_id(post_id);
            ;

            //게시글 삭제하기 DB
            noticeService.deleteNoticeInfo(pDTO);
            ;

            msg = "삭제되었습니다.";

            //변수 초기화(메모리 효율화 시키기 위해 사용함)
            pDTO = null;

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.toString();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeDelete end!");

            //결과 메시지 전달하기
            model.addAttribute("msg", msg);
        }
        return "/notice/MsgToList";

    }

    /***
     *
     * @param request
     * @return 등록 성공여부 반환 1, 0
     * @throws Exception
     */
    @RequestMapping(value = "notice/bookmark_insert")
    @ResponseBody
    public int bookmark_insert(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".bookmark_insert Start!");
        int res = 0;
        try {
            String post_id = CmmUtil.nvl(request.getParameter("post_id"));
            String member_id = CmmUtil.nvl(request.getParameter("member_id"));

            log.info("post_id : " + post_id);
            log.info("member_id : " + member_id);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setPost_id(post_id);
            pDTO.setMember_id(member_id);

            // 북마크 게시물 등록
            noticeService.bookmark_insert(pDTO);

            // 북마크에 따른 추천수 증가
            noticeService.recom_update(pDTO);

            res = 1;

            log.info("success!");
        } catch (Exception e) {

            res = 0;
            log.info(e.toString());
            e.printStackTrace();
        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert end!");
            // 게시물 추천수 증가
        }
        return res;
    }


    // 북마크 삭제
    @RequestMapping(value = "notice/bookmark_delete")
    @ResponseBody
    public int bookmark_delete(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".bookmark_delete Start!");
        int res = 0;

        try {
            String post_id = CmmUtil.nvl(request.getParameter("post_id"));

            log.info("post_id : " + post_id);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setPost_id(post_id);

            // 북마크 게시물 삭제
            noticeService.bookmark_delete(pDTO);

            res = 1;

            log.info("success!");
        } catch (Exception e) {

            res = 0;
            log.info(e.toString());
            e.printStackTrace();
        } finally {
            log.info(this.getClass().getName() + ".bookmark_delete end!");
        }
        return res;
    }

    // 해당 member가 몇개의 게시물을 북마크 했는지 확인
    // 맴버에 해당하는 게시물을 리스트형태로 받아와야함.
    @RequestMapping(value = "notice/bookmark_find")
    @ResponseBody
    public ArrayList<String> bookmark_find(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ". bookmark_find Start!");

        String member_id = CmmUtil.nvl(request.getParameter("member_id")); // 회원번호
        log.info("member_id : " + member_id);

        NoticeDTO rDTO = new NoticeDTO();
        rDTO.setMember_id(member_id);

        List<NoticeDTO> bookmark_find = noticeService.bookmark_find(rDTO);

        if (bookmark_find == null) {
            bookmark_find = new ArrayList<>();
        }

        ArrayList<String> rList = new ArrayList<>();


        Iterator<NoticeDTO> it = bookmark_find.iterator();
        while (it.hasNext()) {
            NoticeDTO pNo = it.next();
            rList.add(pNo.getPost_id());
        }

        // 값 잘들어갔는지 확인
        for (String s : rList) {
            log.info("post no : " + s);
        }

        log.info(this.getClass().getName() + ". bookmark_find END!");

        return rList;
    }

    // 댓글등록
    @RequestMapping(value = "notice/insert_comment")
    @ResponseBody
    public int insert_comment(HttpServletRequest request, HttpSession session)
            throws Exception {

        log.info(this.getClass().getName() + ".insert_comment Start!");
        String member_nic = CmmUtil.nvl((String) session.getAttribute("SS_MEMBER_NIC"));
        String comment_ct = CmmUtil.nvl(request.getParameter("comment"));
        String post_id = CmmUtil.nvl(request.getParameter("post_id"));

        int res;

        try {

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setMember_nic(member_nic); // 댓글작성자 닉네임
            pDTO.setComment_ct(comment_ct); // 댓글내용
            pDTO.setPost_id(post_id); // 게시글 번호


            // 값이 잘 받아졌는지 확인
            log.info("member_nic : " + member_nic);
            log.info("comment_ct : " + comment_ct);
            log.info("post_id : " + post_id);

            // 댓글등록
            noticeService.comment_insert(pDTO);

            res = 1;

            // 메모리를 비워줌
            pDTO = null;

        } catch (Exception e) {
            //저장이 실패되면
            log.info(e.toString());
            e.printStackTrace();

            res = 0;

        } finally {
            log.info(this.getClass().getName() + ".insert_comment END!");
        }
        return res;
    }

    // 댓글 리스트 가져오기
    @RequestMapping(value = "notice/find_comment")
    @ResponseBody
    public List<NoticeDTO> find_comment(HttpServletRequest request) throws Exception {
        log.info(this.getClass().getName() + ".find_comment Start!");

        String post_id = CmmUtil.nvl(request.getParameter("post_id"));
        log.info("post_id : " + post_id);

        NoticeDTO pDTO = new NoticeDTO();
        pDTO.setPost_id(post_id);

        List<NoticeDTO> rList = noticeService.comment_find(pDTO);

        if (rList == null) {
            rList = new ArrayList<>();
        }

        log.info(this.getClass().getName() + ".find_comment END!");

        return rList;
    }

    /**
     * 게시판 리스트 인기순
     */
    @RequestMapping(value = "notice/hit_sort_board", method = RequestMethod.GET)
    public String hit_sort_board(HttpServletRequest request, ModelMap model) throws Exception {

        //로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".hit_sort_board start!");

        // 카테고리 받아오기
        String post_category = CmmUtil.nvl(request.getParameter("category")); //카테고리
        log.info("post_category : " + post_category);

        NoticeDTO rDTO = new NoticeDTO();
        rDTO.setPost_category(post_category);

        //카테고리별 인기 게시물 리스트 가져오기
        List<NoticeDTO> rList = noticeService.hit_sort_board(rDTO);

        if (rList == null) {
            rList = new ArrayList<NoticeDTO>();
        }

        //조회된 리스트 결과값 넣어주기
        model.addAttribute("post_category", post_category);
        model.addAttribute("rList", rList);

        //변수 초기화(메모리 효율화 시키기 위해 사용함)
        rList = null;

        //로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".hit_sort_board end!");

        //함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/notice/NoticeList";
    }



}




