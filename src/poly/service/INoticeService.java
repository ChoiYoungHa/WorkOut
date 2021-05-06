package poly.service;

import poly.dto.NoticeDTO;

public interface INoticeService {

    // 게시글 등록
    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 글 내용 분리
    void ContentNotice(NoticeDTO pDTO) throws Exception;



}
