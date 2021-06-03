package poly.persistance.mapper;

import com.mysql.cj.protocol.x.Notice;
import config.Mapper;
import org.aspectj.weaver.ast.Not;
import poly.dto.Criteria;
import poly.dto.NoticeDTO;

import java.util.List;

@Mapper("NoticeMapper")
public interface INoticeMapper {


    //게시판 리스트
    List<NoticeDTO> getNoticeList() throws Exception;

    // 게시판 분리
    List<NoticeDTO> getNoticeList_Category(NoticeDTO pDTO) throws Exception;

    //게시판 글 등록
    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 글 내용 분리
    void ContentNotice(NoticeDTO pDTO) throws Exception;

    //게시판 상세보기
    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 조회수 업데이트
    void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;

    //게시글 수정
    void updateNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 글 삭제
    void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

    //북마크 게시물 추가
    void bookmark_insert(NoticeDTO pDTO) throws Exception;

    // 추천수 증가
    void recom_update(NoticeDTO pDTO) throws Exception;

    //북마크 게시물 삭제
    void bookmark_delete(NoticeDTO pDTO) throws Exception;

    //북마크 게시물 확인
    List<NoticeDTO> bookmark_find(NoticeDTO pDTO) throws Exception;

    // 댓글 등록
    void comment_insert(NoticeDTO pDTO) throws Exception;

    // 댓글 가져오기
    List<NoticeDTO> comment_find(NoticeDTO pDTO) throws Exception;

    // 게시판 인기순 정렬
    List<NoticeDTO> hit_sort_board(NoticeDTO pDTO) throws Exception;

    // 게시물 검색기능 (제목검색)
    List<NoticeDTO> search_board_title(Criteria pDTO) throws Exception;

    // 게시물 검색기능 (닉네임 검색)
    List<NoticeDTO> search_board_member(Criteria pDTO) throws Exception;

    // 페이징 처리한 게시판 리스트 불러오기
    List<NoticeDTO> selectPaging(Criteria pDTO) throws Exception;

    // 인기순으로 페이징 처리한 게시판 리스트 불러오기
    List<NoticeDTO> selectPaging_sort(Criteria pDTO) throws Exception;

    // 페이징을 위한 게시글 수 카운팅
    int cntNotice(NoticeDTO pDTO) throws Exception;

    // 페이징 검색을 위한 게시글 수 카운팅 게시글제목
    int searchNoticePcn(NoticeDTO pDTO) throws Exception;

    // 페이징 검색을 위한 게시글 수 카운팅 작성자
    int searchNoticeMcn(NoticeDTO pDTO) throws Exception;

    // 댓글 수정하기
    void editComment(NoticeDTO pDTO) throws Exception;

    // 댓글을 수정할 때, 내용 표시를 위해 기존 댓글정보를 가져옴(게시물번호, 작성자이름)
    NoticeDTO getCommentDetail(NoticeDTO pDTO) throws Exception;

    // 댓글 삭제
    void deleteComment(NoticeDTO pDTO) throws Exception;


}
