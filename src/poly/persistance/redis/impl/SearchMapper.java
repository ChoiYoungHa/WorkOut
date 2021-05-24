package poly.persistance.redis.impl;
import org.apache.log4j.Logger;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;
import poly.dto.NoticeDTO;
import poly.persistance.redis.ISearchMapper;
import poly.util.CmmUtil;

import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@Component("SearchMapper")
public class SearchMapper implements ISearchMapper {
    private Logger log = Logger.getLogger(this.getClass());

    @Autowired
    public RedisTemplate<String, Object> redisDB;


    // 최근 검색어 저장
    @Override
    public void insertSearchList(NoticeDTO pDTO) throws Exception {
        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".insertSearchList start!");

        String member_key = pDTO.getMember_id();
        String keyword = pDTO.getKeyWord();

        String redisKey = "MemberNo_" + member_key;

        /*
         * redis 저장 및 읽기에 대한 데이터 타입 지정(String 타입으로 지정함)
         */
        redisDB.setKeySerializer(new StringRedisSerializer()); // String 타입
        redisDB.setValueSerializer(new StringRedisSerializer());


        // 저장된 전체 레코드 수
        long cnt = redisDB.opsForZSet().size(redisKey);

        // 값이 저장될 때 마다 컬렉션 크기 + 1 하면 1,2,3,4 순서대로 저장된다.
        redisDB.opsForZSet().add(redisKey, keyword, cnt+1);
        redisDB.expire(redisKey, 100, TimeUnit.MINUTES); // 1시간40분 후 삭제됨.

        log.info(this.getClass().getName() + ".insertSearchList end!");
    }

    // 최근검색어 불러오기
    @Override
    public Set getSearchList(NoticeDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".getSearchList Start!");

        String member_key = pDTO.getMember_id();

        String redisKey = "MemberNo_" + member_key;

        /*
         * redis 저장 및 읽기에 대한 데이터 타입 지정(String 타입으로 지정함)
         */
        redisDB.setKeySerializer(new StringRedisSerializer()); // String 타입
        redisDB.setValueSerializer(new StringRedisSerializer());

        Set rSet = new LinkedHashSet();

        if (redisDB.hasKey(redisKey)) {

            // 저장된 전체 레코드 수
            long cnt = redisDB.opsForZSet().size(redisKey);
            rSet = (Set) redisDB.opsForZSet().range(redisKey, 0, cnt);

            if (rSet == null) {
                rSet = new LinkedHashSet<String>();
            }

            Iterator<String> it = rSet.iterator();

            while (it.hasNext()) {
                String value = CmmUtil.nvl((String) it.next());
                log.info("value : " + value);
            }
        }

        log.info(this.getClass().getName() + ".getSearchList END!");
        return rSet;
    }
}
