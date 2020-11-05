package com.tt.sns.model.biz;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tt.sns.model.dao.TimelineDao;
import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.FollowDto;
import com.tt.sns.model.dto.LiveDto;
import com.tt.sns.model.dto.MyOpenchatDto;
import com.tt.sns.model.dto.OpenchatDto;
import com.tt.sns.model.dto.ReDto;
import com.tt.sns.model.dto.SaveDto;

@Service
public class TimelineBizImpl implements TimelineBiz {

	@Autowired
	private TimelineDao dao;

	@Override
	public List<ContentDto> contentList(String follow_id) {
		return dao.contentList(follow_id);
	}

	@Override
	public ContentDto contentOne(int content_no) {
		return dao.contentOne(content_no);
	}

	@Override
	public int feedinsert(ContentDto dto) {
		// TODO Auto-generated method stub
		return dao.feedinsert(dto);
	}

	@Override
	public List<ContentDto> mycontentList(String content_users_id) {
		// TODO Auto-generated method stub
		return dao.mycontentList(content_users_id);
	}

	@Override
	public ContentDto weather(int content_no) {
		// TODO Auto-generated method stub
		return dao.weather(content_no);
	}

	@Override
	public int editfeed(ContentDto dto) {
		// TODO Auto-generated method stub
		return dao.editfeed(dto);
	}

	@Override
	public int delete(int content_no) {
		// TODO Auto-generated method stub
		return dao.delete(content_no);
	}

	@Override
	public int commentInsert(ReDto dto) {
		return dao.commentInsert(dto);
	}

	@Override
	public int detailCommentInsert(ReDto dto) {
		return dao.detailCommentInsert(dto);
	}

	@Override
	public List<ReDto> listComment(int content_no) {
		return dao.listComment(content_no);
	}

	@Override
	public int countUpComment(ContentDto content) {
		return dao.countUpComment(content);
	}

	@Override
	public int commentCount(int content_no) {
		return dao.commentCount(content_no);
	}

	// 검색기능 아이디 또는 해시태그
	@Override
	public List<ContentDto> searchList(String keyword) {
		// 반환할 리스트 생성
		List<ContentDto> searchList = new ArrayList<ContentDto>();
		// 만약 #해시태그 검색일 때 && #만 입력 방지
		if (keyword.contains("#") && !(keyword.equals("#"))) {
			// 해시태그가 있는 게시물을 가져와서
			List<ContentDto> hashList = dao.hashList(keyword);
			String hashtag = "";
			String hashtaglist[] = {};

			for (ContentDto dto : hashList) {
				// hashtag에 정제 되지 않은 게시물의 content_hashtag 저장
				hashtag = dto.getContent_hashtag();
				// 공백문자를 기준으로 잘라서 String 배열에 저장
				hashtaglist = hashtag.split(" ");
				for (String str : hashtaglist) {
					// keyword와 비교해서 같은 #태그명 이 존재하면 해당 dto를 searchList에 저장
					if (str.equals(keyword)) {
						searchList.add(dto);
					}
				}
			}
		} else { // 검색어에 입력글자 없을시 모든 게시물 반환
			searchList = dao.allList();
		}
		return searchList;
	}

	@Override
	public int followinsert(FollowDto dto) {
		// TODO Auto-generated method stub
		return dao.followinsert(dto);
	}

	@Override
	public List<FollowDto> followingList(String follow_id) {
		return dao.followingList(follow_id);
	}

	@Override
	public List<FollowDto> followerList(String follow_target) {
		return dao.followerList(follow_target);
	}

	@Override
	public int followcancel(String follow_target) {
		return dao.followcancel(follow_target);
	}

	@Override
	public int searchCount(int content_no) {
		return dao.searchCount(content_no);
	}

	@Override
	public List<ContentDto> allList() {
		return dao.allList();
	}

	@Override
	public List<FollowDto> followList(String follow_id) {
		// TODO Auto-generated method stub
		return dao.followList(follow_id);
	}

	@Override
	public List<ContentDto> searchcontentList(String content_place_name) {

		return dao.searchcontentList(content_place_name);
	}

	@Override
	public String userprofile(String content_user_id) {
		return dao.userprofile(content_user_id);
	}

	@Override
	public int deleteComment(int reno) {
		return dao.deleteComment(reno);
	}

	@Override
	public List<ReDto> listCommentre(int content_no) {
		return dao.listCommentre(content_no);
	}

	@Override
	public int saveContent(SaveDto sdto) {
		return dao.saveContent(sdto);
	}

	@Override
	public List<SaveDto> saveList(String users_id) {
		return dao.saveList(users_id);
	}

	@Override
	public int tagcount(String keyword) {
		int tagcount = 0;
		// keyword로 검색후
		List<ContentDto> searchList = searchList(keyword);
		// searchList.size() == 검색어(users_id || #태그명)와 일치하는 게시물의 개수
		tagcount = searchList.size();
		return tagcount;
	}

	@Override
	public List<FollowDto> recommendList(String userid) {
		return dao.recommendList(userid);
	}

	// 자동완성기능을 위한 태그 검색
	@Override
	public List<ContentDto> autocomplete(String keyword) {
		List<ContentDto> autocomplete = null;

		if (keyword.contains("#") && !keyword.equals("#")) {
			autocomplete = dao.hashList(keyword);
		} else if (keyword.equals("")) {
			autocomplete = dao.allList();
		} else {
			autocomplete = dao.idList(keyword);
		}
		return autocomplete;
	}

	@Override
	public int savedelete(SaveDto save) {
		return dao.savedelete(save);
	}

	@Override
	public int live(LiveDto dto) {
		return dao.live(dto);
	}

	@Override
	public int livestop(String live) {
		return dao.livestop(live);
	}

	@Override
	public List<LiveDto> liveList() {
		return dao.liveList();
	}

	@Override
	public int openchatCreate(OpenchatDto dto) {
		return dao.openchatCreate(dto);
	}

	@Override
	public List<OpenchatDto> openchatlist() {
		return dao.openchatlist();
	}

	@Override
	public int openchatinsert(MyOpenchatDto dto) {
		return dao.openchatinsert(dto);
	}

	@Override
	public List<MyOpenchatDto> myopenchatlist(String users_id) {
		return dao.myopenchatlist(users_id);
	}

	@Override
	public int dminsert(DmDto ddto) {
		return dao.dminsert(ddto);
	}

	@Override
	public List<DmDto> dmlist(String users_id) {
		return dao.dmlist(users_id);
	}

	@Override
	public int openchatexit(MyOpenchatDto mdto) {
		return dao.openchatexit(mdto);
	}

	@Override
	public int dmexit(DmDto ddto) {
		return dao.dmexit(ddto);
	}

	@Override
	public String dmstatus(DmDto ddto) {
		return dao.dmstatus(ddto);
	}

	@Override
	public int dmstatusupdate(DmDto ddto) {
		return dao.dmstatusupdate(ddto);
	}

	@Override
	public List<DmDto> dmlistall(String users_id) {
		return dao.dmlistall(users_id);
	}

	@Override
	public String dmrestatus(DmDto ddto) {
		return dao.dmrestatus(ddto);
	}

	@Override
	public int dmrestatusupdate(DmDto ddto) {
		return dao.dmrestatusupdate(ddto);
	}

	@Override
	public int newdmstatusupdate(DmDto dto) {
		return dao.newdmstatusupdate(dto);
	}
	
	

	
	
}
