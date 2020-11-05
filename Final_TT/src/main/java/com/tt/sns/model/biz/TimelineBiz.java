
package com.tt.sns.model.biz;

import java.util.List;

import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.FollowDto;
import com.tt.sns.model.dto.LiveDto;
import com.tt.sns.model.dto.MyOpenchatDto;
import com.tt.sns.model.dto.OpenchatDto;
import com.tt.sns.model.dto.ReDto;
import com.tt.sns.model.dto.SaveDto;

public interface TimelineBiz {
	public List<ContentDto> contentList(String follow_id);

	public ContentDto contentOne(int content_no);

	public int feedinsert(ContentDto dto);

	public List<ContentDto> mycontentList(String content_users_id);

	public ContentDto weather(int content_no);

	public int editfeed(ContentDto dto);

	public int delete(int content_no);

	public int commentInsert(ReDto dto);

	public int detailCommentInsert(ReDto dto);

	public List<ReDto> listComment(int content_no);
	
	public List<ReDto> listCommentre(int content_no);
	
	public int commentCount(int content_no);
	
	public int countUpComment(ContentDto content);
	
	public int searchCount(int content_no);

	public List<ContentDto> searchList(String keyword);
	
	public int followinsert(FollowDto dto);
	
	public int followcancel(String follow_target);
	
	public List<FollowDto> followingList(String follow_id);
	
	public List<FollowDto> followerList(String follow_target);
	
	public List<FollowDto> followList(String follow_id);
	
	public List<ContentDto> allList();
	
	public List<ContentDto> searchcontentList(String content_place_name);
	
	public String userprofile(String contnet_user_id);
	
	public int deleteComment(int reno);
	
	public int saveContent(SaveDto sdto);
	
	public List<SaveDto> saveList(String users_id);
	
	public int tagcount(String keyword);
	
	public List<FollowDto> recommendList(String userid);
	
	public List<ContentDto> autocomplete(String keyword);
	
	public int savedelete(SaveDto save);
	
	public int live(LiveDto dto);
	
	public int livestop(String live);
	
	public List<LiveDto> liveList();
	
	public int openchatCreate(OpenchatDto dto);
	
	public List<OpenchatDto> openchatlist();
	
	public int openchatinsert(MyOpenchatDto dto);
	
	public List<MyOpenchatDto> myopenchatlist(String users_id);
	
	public int dminsert(DmDto ddto);
	
	public List<DmDto> dmlist(String users_id);
	
	public int openchatexit(MyOpenchatDto mdto);
	
	public int dmexit(DmDto ddto);
	
	public String dmstatus(DmDto ddto);
	
	public int dmstatusupdate(DmDto ddto);
	
	public List<DmDto> dmlistall(String users_id);
	
	public String dmrestatus(DmDto ddto);
	
	public int dmrestatusupdate(DmDto ddto);
	
	public int newdmstatusupdate(DmDto dto);
	
}
