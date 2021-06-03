package poly.service.impl;

import org.springframework.stereotype.Service;
import poly.dto.Criteria;
import poly.dto.NoticeDTO;
import poly.persistance.mapper.INoticeMapper;
import poly.service.INoticeService;

import javax.annotation.Resource;
import java.util.List;

@Service("NoticeService")
public class NoticeService implements INoticeService {

    @Resource(name = "NoticeMapper")
    private INoticeMapper noticeMapper;
    // 게시글 리스트 가져오기
    @Override
    public List<NoticeDTO> getNoticeList() throws Exception {
        return noticeMapper.getNoticeList();
    }


    // 카테고리별 게시판 리스트 가져오기
    @Override
    public List<NoticeDTO> getNoticeList_Category(NoticeDTO pDTO) throws Exception {
        return noticeMapper.getNoticeList_Category(pDTO);
    }


    // 게시글 등록
    @Override
    public void InsertNoticeInfo(NoticeDTO pDTO) throws Exception {
        noticeMapper.InsertNoticeInfo(pDTO);
    }

    // 게시글 내용등록 (분리)
    @Override
    public void ContentNotice(NoticeDTO pDTO) throws Exception {
        noticeMapper.ContentNotice(pDTO);
    }

    // 게시글 상세보기
    @Override
    public NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception {
        return noticeMapper.getNoticeInfo(pDTO);
    }

    // 게시글 조회수 카운트
    @Override
    public void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception {
        noticeMapper.updateNoticeReadCnt(pDTO);
    }

    // 게시글 수정
    @Override
    public void updateNoticeInfo(NoticeDTO pDTO) throws Exception {
        noticeMapper.updateNoticeInfo(pDTO);
    }

    // 게시글 삭제
    @Override
    public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {
        noticeMapper.deleteNoticeInfo(pDTO);
    }

    // 북마크 게시물 추가
    @Override
    public void bookmark_insert(NoticeDTO pDTO) throws Exception {
        noticeMapper.bookmark_insert(pDTO);
    }

    @Override
    public void recom_update(NoticeDTO pDTO) throws Exception {
        noticeMapper.recom_update(pDTO);
    }

    // 북마크 게시물 삭제
    @Override
    public void bookmark_delete(NoticeDTO pDTO) throws Exception {
        noticeMapper.bookmark_delete(pDTO);
    }

    // 북마크 게시물 확인
    @Override
    public List<NoticeDTO> bookmark_find(NoticeDTO pDTO) throws Exception {
        return noticeMapper.bookmark_find(pDTO);
    }

    // 댓글 등록
    @Override
    public void comment_insert(NoticeDTO pDTO) throws Exception {
        noticeMapper.comment_insert(pDTO);
    }

    // 댓글 가져오기
    @Override
    public List<NoticeDTO> comment_find(NoticeDTO pDTO) throws Exception {
        return noticeMapper.comment_find(pDTO);
    }

    // 게시판 인기순 정렬
    @Override
    public List<NoticeDTO> hit_sort_board(NoticeDTO pDTO) throws Exception {
        return noticeMapper.hit_sort_board(pDTO);
    }


    // 게시글 제목으로 검색
    @Override
    public List<NoticeDTO> search_board_title(Criteria pDTO) throws Exception {
        return noticeMapper.search_board_title(pDTO);
    }

    // 글쓴이로 검색
    @Override
    public List<NoticeDTO> search_board_member(Criteria pDTO) throws Exception {
        return noticeMapper.search_board_member(pDTO);
    }

    // 페이징 처리한 게시판 리스트 불러오기
    @Override
    public List<NoticeDTO> selectPaging(Criteria pDTO) throws Exception {
        return noticeMapper.selectPaging(pDTO);
    }
    // 인기순으로 페이징 처리한 게시판 리스트 불러오기
    @Override
    public List<NoticeDTO> selectPaging_sort(Criteria pDTO) throws Exception {
        return noticeMapper.selectPaging_sort(pDTO);
    }
    // 페이징을 위한 게시글 수 카운팅
    @Override
    public int cntNotice(NoticeDTO pDTO) throws Exception {
        return noticeMapper.cntNotice(pDTO);
    }
    // 페이징 검색을 위한 게시글 수 카운팅 게시글제목
    @Override
    public int searchNoticePcn(NoticeDTO pDTO) throws Exception {
        return noticeMapper.searchNoticePcn(pDTO);
    }

    // 페이징 검색을 위한 게시글 수 카운팅 작성자
    @Override
    public int searchNoticeMcn(NoticeDTO pDTO) throws Exception {
        return noticeMapper.searchNoticeMcn(pDTO);
    }

    // 댓글 수정하기
    @Override
    public void editComment(NoticeDTO pDTO) throws Exception {
        noticeMapper.editComment(pDTO);
    }

    // 댓글을 수정할 때, 내용 표시를 위해 기존 댓글정보를 가져옴(게시물번호, 작성자이름)
    @Override
    public NoticeDTO getCommentDetail(NoticeDTO pDTO) throws Exception {
        return noticeMapper.getCommentDetail(pDTO);
    }

    // 댓글 삭제
    @Override
    public void deleteComment(NoticeDTO pDTO) throws Exception {
        noticeMapper.deleteComment(pDTO);
    }

}
