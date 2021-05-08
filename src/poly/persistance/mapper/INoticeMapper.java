package poly.persistance.mapper;

import config.Mapper;
import poly.dto.NoticeDTO;

import java.util.List;

@Mapper("NoticeMapper")
public interface INoticeMapper {


    //게시판 리스트
    List<NoticeDTO> getNoticeList() throws Exception;

    //게시판 글 등록
    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 글 내용 분리
    void ContentNotice(NoticeDTO pDTO) throws Exception;

    //게시판 상세보기
    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 조회수 업데이트
    void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;






}
