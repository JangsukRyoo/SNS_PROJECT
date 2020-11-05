package com.tt.sns.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.FollowDto;
import com.tt.sns.model.dto.LiveDto;
import com.tt.sns.model.dto.MyOpenchatDto;
import com.tt.sns.model.dto.OpenchatDto;
import com.tt.sns.model.dto.ReDto;
import com.tt.sns.model.dto.SaveDto;

@Repository
public class TimelineDaoImpl implements TimelineDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	private Logger logger = LoggerFactory.getLogger(TimelineDao.class);
	@Override
	public List<ContentDto> contentList(String follow_id) {
		List<ContentDto> contentList = null;
		
		contentList = sqlSession.selectList(NAMESPACE+"contentList",follow_id);
		return contentList;
	}

	@Override
	public ContentDto contentOne(int content_no) {
		ContentDto dto = null;

		try {
			dto = sqlSession.selectOne(NAMESPACE + "contentOne", content_no);
		} catch (Exception e) {
			System.out.println("[ERROR] : contentOne");
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public int feedinsert(ContentDto dto) {
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "feedinsert", dto);
		} catch (Exception e) {
			System.out.println("[ERROR] : feedinsert");
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ContentDto> mycontentList(String content_users_id) {
		List<ContentDto> mylist = new ArrayList<ContentDto>();

		try {
			mylist = sqlSession.selectList(NAMESPACE + "mycontentlist", content_users_id);
		} catch (Exception e) {
			System.out.println("[ERROR] : mycontentList");
			e.printStackTrace();
		}

		return mylist;
	}

	@Override
	public ContentDto weather(int content_no) {
		ContentDto dto = null;

		try {
			dto = sqlSession.selectOne(NAMESPACE + "weather", content_no);
		} catch (Exception e) {
			System.out.println("[ERROR] : weather");
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public int editfeed(ContentDto dto) {
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "editfeed", dto);
		} catch (Exception e) {
			System.out.println("[ERROR] : editfeed");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int delete(int content_no) {
		int res = 0;
		int res2 = 0;
		int res3 = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "delete", content_no);
			res2 = sqlSession.delete(NAMESPACE + "delete_comment", content_no);
			res3 = sqlSession.delete(NAMESPACE + "delete_like", content_no);
		} catch (Exception e) {
			System.out.println("[ERROR] : delete");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int commentInsert(ReDto dto) {
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "insertComment", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int detailCommentInsert(ReDto dto) {
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "insertComment", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public List<ReDto> listComment(int content_no) {
		List<ReDto> res = null;
		res = new ArrayList<ReDto>();

		try {
			res = sqlSession.selectList(NAMESPACE + "selectRe", content_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}
	
	@Override
	public int countUpComment(ContentDto content) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "countUpComment", content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return res;
	}

	@Override
	public int commentCount(int content_no) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "commentCount", content_no);
			System.out.println(res);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}


	@Override
	public List<ContentDto> searchUser(String keyword) {
		List<ContentDto> searchList = null;
		logger.info("SEARCH DAO");
		try {
			searchList = sqlSession.selectList(NAMESPACE + "searchUser", keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchList;
	}

	@Override
	public int followinsert(FollowDto dto) {
		int res = 0;
		logger.info("followinsert");
		
		try {
			res= sqlSession.insert(NAMESPACE+"followinsert",dto);
		} catch (Exception e) {
			System.out.println("[ERROR] : followinsert");
			e.printStackTrace();
		}
		return res;
	}
	
	@Override
	public int followcancel(String follow_target) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"followcancel", follow_target);
		} catch (Exception e) {
			System.out.println("[ERROR] : followcancel");
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<FollowDto> followingList(String follow_id) {
		List<FollowDto> dto = null;
		try {
			dto = sqlSession.selectList(NAMESPACE+"followingList", follow_id);
		} catch (Exception e) {
			System.out.println("[ERROR] : followingList");
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<FollowDto> followerList(String follow_target) {
		List<FollowDto> dto = null;
		
		try {
			dto = sqlSession.selectList(NAMESPACE+"followerList",follow_target);
		} catch (Exception e) {
			System.out.println("[ERROR] : followerList");
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int searchCount(int content_no) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "searchCount", content_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	
	@Override
	public List<ContentDto> allList() {
		List<ContentDto> allList = null;

		try {
			allList = sqlSession.selectList(NAMESPACE + "allList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allList;
	}

	@Override
	public List<ContentDto> hashList(String hashtag) {
		List<ContentDto> hashList = null;
		try {
			logger.info("HASHTAG SEARCH");
			hashList = sqlSession.selectList(NAMESPACE + "hashList", hashtag);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hashList;
	}
	
	@Override
	public List<FollowDto> followList(String follow_id) {
		List<FollowDto> dto =null;
		 try {
			dto = sqlSession.selectList(NAMESPACE+"followList",follow_id);
			System.out.println(dto);
		} catch (Exception e) {
			System.out.println("[ERROR] : followListdaoimpl");
			e.printStackTrace();
		}
		return dto;
	}
	

	@Override
	   public List<ContentDto> searchcontentList(String content_place_name) {
	      List<ContentDto> dto = null;
	      
	      try {
	         dto = sqlSession.selectList(NAMESPACE+"searchcontentList",content_place_name);
	      } catch (Exception e) {
	         System.out.println("[ERROR] : searchcontentList");
	         e.printStackTrace();
	      }
	      return dto;
	   }

	@Override
	public String userprofile(String content_user_id) {
		String res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "userprofile", content_user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}
	
	@Override
	public int deleteComment(int reno) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "deleteComment", reno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<ReDto> listCommentre(int content_no) {
		List<ReDto> res = null;
		res = new ArrayList<ReDto>();

		try {
			res = sqlSession.selectList(NAMESPACE + "selectRere", content_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int saveContent(SaveDto sdto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "save",sdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<SaveDto> saveList(String users_id) {
		List<SaveDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "saveList", users_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<FollowDto> recommendList(String userid) {
		List<FollowDto> res = null;
		
		res = sqlSession.selectList(NAMESPACE + "recommend", userid);
		
		return res;
	}

	@Override
	public List<ContentDto> idList(String keyword) {
		List<ContentDto> res = null;
		try {
			res = sqlSession.selectList(NAMESPACE+"idList", keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int savedelete(SaveDto save) {
		int res = 0;
		
		res = sqlSession.delete(NAMESPACE + "savedelete", save);
		
		return res;
	}

	@Override
	public int live(LiveDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "live", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}
	
	@Override
	public int livestop(String live) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "livestop", live);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public List<LiveDto> liveList() {
		List<LiveDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "livelist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int openchatCreate(OpenchatDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "openchatcreate", dto);
		} catch (Exception e) {
			res = 0;
		}
		
		
		return res;
	}

	@Override
	public List<OpenchatDto> openchatlist() {
		List<OpenchatDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "openchatlist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int openchatinsert(MyOpenchatDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "openchatinsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public List<MyOpenchatDto> myopenchatlist(String users_id) {
		List<MyOpenchatDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "myopenchatlist", users_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int dminsert(DmDto ddto) {
		int res = 0;
		int res2 = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "dminsert", ddto);
			res2 = sqlSession.insert(NAMESPACE + "dminsert2", ddto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public List<DmDto> dmlist(String users_id) {
		List<DmDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "dmlist", users_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int openchatexit(MyOpenchatDto odto) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "openchatexit", odto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int dmexit(DmDto ddto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "dmexit", ddto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public String dmstatus(DmDto ddto) {
		String res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "dmstatus", ddto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int dmstatusupdate(DmDto ddto) {
		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "dmstatusupdate", ddto);
		
		return res;
	}

	@Override
	public List<DmDto> dmlistall(String users_id) {
		List<DmDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE + "dmlistall", users_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
		
	}

	@Override
	public int dmrestatusupdate(DmDto ddto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "dmrestatusupdate", ddto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public String dmrestatus(DmDto ddto) {
		String res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "dmrestatus", ddto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int newdmstatusupdate(DmDto dto) {
		int res = 0;
		
		String status = null;
		
		try {
			status = sqlSession.selectOne(NAMESPACE + "newdmstatus", dto);
			
			if(status.equals("N")) {
				res = sqlSession.update(NAMESPACE + "newdmstatusupdate", dto);
			}else {
				res = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	
}
