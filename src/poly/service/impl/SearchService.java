package poly.service.impl;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Service;
import poly.dto.NoticeDTO;
import poly.persistance.redis.ISearchMapper;
import poly.service.ISearchService;

import javax.annotation.Resource;
import java.util.Set;

@Service("SearchService")
public class SearchService implements ISearchService {

    @Resource(name = "SearchMapper")
    private ISearchMapper searchMapper;

    private Logger log = Logger.getLogger(this.getClass());

    // 최근 검색어 저장
    @Override
    public void insertSearchList(NoticeDTO pDTO) throws Exception {
        searchMapper.insertSearchList(pDTO);
    }

    // 최근 검색어 불러오기
    @Override
    public Set getSearchList(NoticeDTO pDTO) throws Exception {
        return searchMapper.getSearchList(pDTO);
    }
}
