package poly.service;

import poly.dto.NoticeDTO;

import java.util.List;

public interface INoticeService {

    // 게시글 리스트 가져오기
    List<NoticeDTO> getNoticeList() throws Exception;

    // 게시판 분리 운동게시판
    List<NoticeDTO> getNoticeList_Work(NoticeDTO pDTO) throws Exception;

    // 게시글 등록
    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;

    // 게시판 글 내용 분리
    void ContentNotice(NoticeDTO pDTO) throws Exception;

    // 게시글 상세보기
    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    // 게시글 조회수 카운트
    void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;

    // 게시글 수정
    void updateNoticeInfo(NoticeDTO pDTO) throws Exception;

    // 게시글 삭제
    void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;



}
