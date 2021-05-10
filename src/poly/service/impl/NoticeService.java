package poly.service.impl;

import org.springframework.stereotype.Service;
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
    // 게시판 분리 운동게시판
    @Override
    public List<NoticeDTO> getNoticeList_Work(NoticeDTO pDTO) throws Exception {
        return noticeMapper.getNoticeList_Work(pDTO);
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

    @Override
    public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {
        noticeMapper.deleteNoticeInfo(pDTO);
    }
}
