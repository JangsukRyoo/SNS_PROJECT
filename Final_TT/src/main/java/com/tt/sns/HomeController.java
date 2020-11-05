package com.tt.sns;

import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import com.tt.sns.model.biz.LikeBiz;
import com.tt.sns.model.biz.LoginBiz;
import com.tt.sns.model.biz.MariaBiz;
import com.tt.sns.model.biz.TimelineBiz;
import com.tt.sns.model.dto.ContentDto;
import com.tt.sns.model.dto.DmDto;
import com.tt.sns.model.dto.DmsubDto;
import com.tt.sns.model.dto.FollowDto;
import com.tt.sns.model.dto.LikeDto;
import com.tt.sns.model.dto.LiveDto;
import com.tt.sns.model.dto.MyOpenchatDto;
import com.tt.sns.model.dto.OpenchatDto;
import com.tt.sns.model.dto.OpenchatsubDto;
import com.tt.sns.model.dto.ReDto;
import com.tt.sns.model.dto.SaveDto;
import com.tt.sns.model.dto.UsersDto;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	@Autowired
	private TimelineBiz biz;
	@Autowired
	private LikeBiz lbiz;
	@Autowired
	private LoginBiz Lbiz;
	@Autowired
	private MariaBiz mbiz;

	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
				DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		// mav.addObject("mylist2", biz.mycontentList(users_id));

		List<ContentDto> contentDto = null;
		contentDto = biz.mycontentList(users_id);
		List<LikeDto> likeDto = null;
		likeDto = new ArrayList<LikeDto>();
		LikeDto ldto = null;

		for (int i = 0; i < contentDto.size(); i++) {
			ldto = new LikeDto();
			ldto.setUsers(users_id);
			ldto.setContent(contentDto.get(i).getContent_no());
			String like_liked = lbiz.select(ldto);
			ldto.setLike_liked(like_liked);
			likeDto.add(ldto);

		}

		List<ContentDto> contentList = biz.contentList(users_id);

		List<String> profilelist = null;
		profilelist = new ArrayList<String>();

		for (int i = 0; i < contentList.size(); i++) {
			String profile = null;
			profilelist.add(
					biz.userprofile(contentList.get(i).getContent_users_id()));
		}

		List<ContentDto> contentDto_home = null;
		contentDto_home = biz.contentList(users_id);
		List<LikeDto> likeDto_home = null;
		likeDto_home = new ArrayList<LikeDto>();
		LikeDto ldto_home = null;

		for (int i = 0; i < contentDto_home.size(); i++) {
			ldto_home = new LikeDto();
			ldto_home.setUsers(users_id);
			ldto_home.setContent(contentDto_home.get(i).getContent_no());
			String like_liked_home = lbiz.select(ldto_home);
			ldto_home.setLike_liked(like_liked_home);
			likeDto_home.add(ldto_home);

		}

		List<ContentDto> allList = biz.allList();

		List<ContentDto> mylist = biz.mycontentList(users_id);

		List<List<ReDto>> listcomment = null;
		listcomment = new ArrayList<List<ReDto>>();
		List<ReDto> re_home = null;
		String re_profile = null;

		for (int i = 0; i < contentDto_home.size(); i++) {
			re_home = null;
			re_profile = null;
			re_home = biz.listCommentre(contentDto_home.get(i).getContent_no());
			for (int j = 0; j < re_home.size(); j++) {
				re_profile = biz.userprofile(re_home.get(j).getUserid());
				re_home.get(j).setRe_userprofile(re_profile);
			}
			listcomment.add(re_home);
		}
		List<String> hash = new ArrayList<String>();
		List<List<String>> hashlist = new ArrayList<List<String>>();
		List<String> hash_search = new ArrayList<String>();
		List<List<String>> hashlist_search = new ArrayList<List<String>>();
		List<String> hash_my = new ArrayList<String>();
		List<List<String>> hashlist_my = new ArrayList<List<String>>();

		StringTokenizer st = null;
		StringTokenizer st2 = null;
		StringTokenizer st3 = null;

		for (int i = 0; i < contentList.size(); i++) {
			hash = null;
			hash = new ArrayList<String>();
			st = new StringTokenizer(contentList.get(i).getContent_hashtag(),
					"#");

			while (st.hasMoreTokens()) {
				hash.add(st.nextToken().trim());
			} ;

			hashlist.add(hash);
		}

		for (int i = 0; i < allList.size(); i++) {
			hash_search = null;
			hash_search = new ArrayList<String>();
			st2 = new StringTokenizer(allList.get(i).getContent_hashtag(), "#");

			while (st2.hasMoreTokens()) {
				hash_search.add(st2.nextToken().trim());
			} ;

			hashlist_search.add(hash_search);
		}

		for (int i = 0; i < mylist.size(); i++) {
			hash_my = null;
			hash_my = new ArrayList<String>();
			st3 = new StringTokenizer(mylist.get(i).getContent_hashtag(), "#");

			while (st3.hasMoreTokens()) {
				hash_my.add(st3.nextToken().trim());
			} ;

			hashlist_my.add(hash_my);
		}

		List<List<String>> imagelist = new ArrayList<List<String>>();
		List<String> image = null;
		StringTokenizer imagetoken = null;

		for (int i = 0; i < contentList.size(); i++) {
			image = null;
			image = new ArrayList<String>();
			imagetoken = new StringTokenizer(
					contentList.get(i).getContent_photo(), " ");

			while (imagetoken.hasMoreTokens()) {
				image.add(imagetoken.nextToken());
			} ;

			imagelist.add(image);

		}

		List<List<String>> imagemyList = new ArrayList<List<String>>();
		List<String> imagemy = null;
		StringTokenizer imagemytoken = null;

		for (int i = 0; i < mylist.size(); i++) {
			imagemy = null;
			imagemy = new ArrayList<String>();
			imagemytoken = new StringTokenizer(mylist.get(i).getContent_photo(),
					" ");

			while (imagemytoken.hasMoreTokens()) {
				imagemy.add(imagemytoken.nextToken());
			} ;

			imagemyList.add(imagemy);
		}

		List<List<String>> searchimage = new ArrayList<List<String>>();
		List<String> imagesearch = null;
		StringTokenizer searchtok = null;

		for (int i = 0; i < allList.size(); i++) {
			imagesearch = null;
			imagesearch = new ArrayList<String>();
			searchtok = new StringTokenizer(allList.get(i).getContent_photo(),
					" ");

			while (searchtok.hasMoreTokens()) {
				imagesearch.add(searchtok.nextToken());
			} ;

			searchimage.add(imagesearch);
		}

		List<SaveDto> saveList = biz.saveList(users_id);
		List<Integer> clist = new ArrayList<Integer>();

		for (int i = 0; i < saveList.size(); i++) {
			clist.add(saveList.get(i).getSave_content_no());
		}

		model.addAttribute("clist", clist);
		// 마이페이지 게시물 리스트
		model.addAttribute("mylist2", mylist);
		// 마이페이지 이미리 리스트
		model.addAttribute("imagemyList", imagemyList);
		// 마이페이지 해쉬 리스트
		model.addAttribute("hashlist", hashlist);
		model.addAttribute("hashlist_search", hashlist_search);
		model.addAttribute("hashlist_my", hashlist_my);
		model.addAttribute("imagesearchList", searchimage);

		// 타임라인 팔로잉 게시물 리스트
		model.addAttribute("contentList", contentList);
		// 타임라인 이미지 리스트
		model.addAttribute("imageList", imagelist);
		// 마이페이지 게시물 좋아요 리스트
		model.addAttribute("likeDto", likeDto);
		// 타임라인 팔로잉 게시물 좋아요 리스트
		model.addAttribute("likeDto_home", likeDto_home);
		model.addAttribute("commentlist", listcomment);
		model.addAttribute("allList", allList);
		model.addAttribute("profilelist", profilelist);
		model.addAttribute("userinfo", Lbiz.userinfo(users_id));

		return "timeline";
	}

	@RequestMapping("/timelinedetail.do")
	public String modal(Model model, int content_no, HttpSession session,
			int index, String button1, String button2) {
		logger.info("timelinedetail");
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String user_id = null;
		user_id = dto.getUsers_id();

		LikeDto ldto = null;
		ldto = new LikeDto();
		ldto.setContent(content_no);
		ldto.setUsers(user_id);
		String like_liked = lbiz.select(ldto);
		ldto.setLike_liked(like_liked);

		String user_profile = null;
		String user_pf = null;

		List<ReDto> relist = null;
		relist = biz.listComment(content_no);

		for (int i = 0; i < relist.size(); i++) {
			user_pf = biz.userprofile(relist.get(i).getUserid());
			relist.get(i).setRe_userprofile(user_pf);
		}

		ContentDto weather = null;
		weather = biz.weather(content_no);

		String content_user_id = weather.getContent_users_id();

		String userprofile = null;
		userprofile = biz.userprofile(content_user_id);

		List<String> imageList = null;
		imageList = new ArrayList<String>();
		StringTokenizer st = new StringTokenizer(weather.getContent_photo(),
				" ");

		while (st.hasMoreTokens()) {
			imageList.add(st.nextToken());
		}

		List<SaveDto> saveList = biz.saveList(user_id);
		List<Integer> clist = new ArrayList<Integer>();

		for (int i = 0; i < saveList.size(); i++) {
			clist.add(saveList.get(i).getSave_content_no());
		}

		model.addAttribute("clist", clist);
		model.addAttribute("userprofile", userprofile);
		model.addAttribute("button1", button1);
		model.addAttribute("button2", button2);
		model.addAttribute("index", index);
		model.addAttribute("dto", weather);
		model.addAttribute("list", relist);
		model.addAttribute("like", ldto);
		model.addAttribute("useridss", user_id);
		model.addAttribute("imageList", imageList);
		return "timeline-detail";
	}

	@RequestMapping("/mypage.do")
	public String mypage() {
		return "mypage";
	}

	@RequestMapping("/ms.do")
	public String message(Model model, HttpSession session) {
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		List<LiveDto> liveListDto = null;
		liveListDto = biz.liveList();

		List<OpenchatDto> openchatlistDto = null;
		openchatlistDto = biz.openchatlist();

		List<MyOpenchatDto> myopenchatlistDto = null;
		myopenchatlistDto = biz.myopenchatlist(users_id);

		List<DmDto> dmlistDto = null;
		dmlistDto = biz.dmlist(users_id);

		List<DmDto> dmlist = new ArrayList<DmDto>();

		for (int i = 0; i < dmlistDto.size(); i++) {
			if (!dmlistDto.get(i).getDm_receiver().equals(users_id)) {
				dmlist.add(dmlistDto.get(i));
			}
		}

		List<String> dmprofilelist = null;
		dmprofilelist = new ArrayList<String>();

		String profile = null;
		for (int i = 0; i < dmlist.size(); i++) {
			profile = null;
			profile = biz.userprofile(dmlist.get(i).getDm_receiver());
			dmprofilelist.add(profile);
		}

		model.addAttribute("id", users_id);
		model.addAttribute("livelist", liveListDto);
		model.addAttribute("openchatlist", openchatlistDto);
		model.addAttribute("myopenchatlist", myopenchatlistDto);
		model.addAttribute("dmlist", dmlist);
		model.addAttribute("dmprofilelist", dmprofilelist);

		return "ms";
	}

	@RequestMapping("/weather.do")
	public String weather(Model model, int content_no,
			String content_place_name, HttpSession session) {
		logger.info("weather");
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String user_id = null;
		user_id = dto.getUsers_id();

		List<ContentDto> contentDto = null;
		contentDto = biz.searchcontentList(content_place_name);
		List<LikeDto> likeDto = null;
		likeDto = new ArrayList<LikeDto>();
		LikeDto ldto = null;

		for (int i = 0; i < contentDto.size(); i++) {
			ldto = new LikeDto();
			ldto.setUsers(user_id);
			ldto.setContent(contentDto.get(i).getContent_no());
			String like_liked = lbiz.select(ldto);
			ldto.setLike_liked(like_liked);
			likeDto.add(ldto);

		}

		List<String> image = null;
		List<List<String>> imageList = new ArrayList<List<String>>();
		StringTokenizer st = null;

		for (int i = 0; i < contentDto.size(); i++) {
			image = null;
			image = new ArrayList<String>();
			st = new StringTokenizer(contentDto.get(i).getContent_photo(), " ");

			while (st.hasMoreTokens()) {
				image.add(st.nextToken());
			}

			imageList.add(image);
		}
		model.addAttribute("imageList", imageList);
		model.addAttribute("searchcontentList",
				biz.searchcontentList(content_place_name));
		model.addAttribute("likeDto", likeDto);
		model.addAttribute("dto", biz.weather(content_no));
		return "weather";
	}

	@RequestMapping("/followform.do")
	public String followinsert(FollowDto dto) {
		logger.info("followform.do");

		int res = biz.followinsert(dto);
		if (res > 0) {
			return "redirect:friendmypage.do?content_users_id="
					+ dto.getFollow_target();
		} else {
			return "redirect:friendmypage.do";
		}
	}

	@RequestMapping("/following_cancel.do")
	public String following_cancel(String follow_target) {
		logger.info("following_cancel");

		int res = biz.followcancel(follow_target);
		return "redirect:home.do" + "#home";
	}

	@RequestMapping("/follow.do")
	public String follow(Model model, String follow_id, FollowDto dto) {
		logger.info("followingList");
		model.addAttribute("follow", biz.followingList(follow_id));
		return "follow";
	}

	@RequestMapping("/follower.do")
	public String follower(Model model, String follow_target) {
		logger.info("followerList");
		model.addAttribute("follower", biz.followerList(follow_target));
		return "follower";
	}

	@RequestMapping("/profilecomfile.do")
	public String profilecomfile(Model model, HttpSession session) {
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		model.addAttribute("userinfo", Lbiz.userinfo(users_id));

		return "profilecomfile";
	}

	@RequestMapping("/insertfeed.do")
	public String insertfeed() {
		return "insertfeed";
	}

	@RequestMapping("/editfeed.do")
	public String editfeedform(Model model, int content_no) {
		logger.info("editfeedform");
		model.addAttribute("dto", biz.weather(content_no));
		return "editfeed";
	}

	@RequestMapping("/friendmypage.do")
	public String friendmypageform(Model model, String content_users_id,
			HttpSession session) {
		logger.info("friend");

		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		List<ContentDto> contentDto = null;
		contentDto = biz.mycontentList(content_users_id);
		List<LikeDto> likeDto = null;
		likeDto = new ArrayList<LikeDto>();
		LikeDto ldto = null;

		for (int i = 0; i < contentDto.size(); i++) {
			ldto = new LikeDto();
			ldto.setUsers(users_id);
			ldto.setContent(contentDto.get(i).getContent_no());
			String like_liked = lbiz.select(ldto);
			ldto.setLike_liked(like_liked);
			likeDto.add(ldto);

		}

		List<ContentDto> contentList = biz.mycontentList(content_users_id);

		List<String> image = null;
		List<List<String>> imageList = new ArrayList<List<String>>();
		StringTokenizer st = null;

		for (int i = 0; i < contentList.size(); i++) {
			image = null;
			image = new ArrayList<String>();
			st = new StringTokenizer(contentList.get(i).getContent_photo(),
					" ");

			while (st.hasMoreTokens()) {
				image.add(st.nextToken());
			}

			imageList.add(image);
		}

		model.addAttribute("likeDto", likeDto);
		model.addAttribute("dto", contentList);
		model.addAttribute("imageList", imageList);
		// 페이지 주인 정보
		model.addAttribute("userinfo", Lbiz.userinfo(content_users_id));
		// 로그인한 회원 의 팔로잉 리스트
		model.addAttribute("followlist", biz.followList(users_id));
		if (users_id.equals(content_users_id)) {
			return "redirect:home.do" + "#home";
		} else {
			return "friendmypage";
		}

	}

	@RequestMapping("/delete.do")
	public String delete(int content_no) {
		logger.info("delete");
		int res = biz.delete(content_no);

		if (res > 0) {
			return "redirect:home.do" + "#home";
		} else {
			return "redirect:home.do";
		}

	}

	@RequestMapping("/editupload.do")
	public String editupload(MultipartHttpServletRequest request, Model model,
			ContentDto dto, BindingResult result) throws Exception {

		logger.info("editupload");
		// contnet_no 기존 게시물 정보 가져옴
		ContentDto oldDto = biz.weather(dto.getContent_no());

		UUID uuid = UUID.randomUUID();

		String filePath = WebUtils.getRealPath(
				request.getSession().getServletContext(),
				"/resources/images/content/");

		File content = new File(filePath);
		if (!content.exists()) {
			content.mkdir();
		}

		Iterator<String> iterator = request.getFileNames();
		String content_photo = null;
		String content_photo_origin = null;

		List<String> name = new ArrayList<String>();

		while (iterator.hasNext()) {
			String flTagNm = iterator.next();
			List<MultipartFile> flLst = request.getFiles(flTagNm);

			for (MultipartFile file : flLst) {
				System.out.println("업로드 성공");
				content_photo_origin = file.getOriginalFilename();

				// 게시물 수정 시 사진업로드 안 할 경우
				if (content_photo_origin.equals("")
						|| content_photo_origin.equals(null)) {
					content_photo = oldDto.getContent_photo();
				} else {
					content_photo = uuid.toString() + content_photo_origin;
					try {
						file.transferTo(new File(filePath + content_photo));
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println("업로드 중 오류!!!!!!!");
					}
				}
				name.add(content_photo);
			}
		}
		StringBuilder br = new StringBuilder();
		for (int i = 0; i < name.size(); i++) {
			if (i != name.size() - 1) {
				br.append(name.get(i) + " ");
			} else {
				br.append(name.get(i));
			}
		}
		dto.setContent_photo(br.toString());

		// 게시물 수정 시 장소태그 안 할 경우
		if (dto.getContent_place_name().equals("")
				|| dto.getContent_place_name().equals(null)) {
			dto.setContent_place_name(oldDto.getContent_place_name());
			dto.setContent_place_lat(oldDto.getContent_place_lat());
			dto.setContent_place_lon(oldDto.getContent_place_lon());
		}

		int res = biz.editfeed(dto);

		return "redirect:home.do" + "#home";
	}

	@RequestMapping("/upload.do")
	public String upload(MultipartHttpServletRequest request, Model model,
			ContentDto dto, BindingResult result) throws Exception {

		logger.info("feedinsert");
		UUID uuid = UUID.randomUUID();

		String filePath = WebUtils.getRealPath(
				request.getSession().getServletContext(),
				"/resources/images/content/");

		File content = new File(filePath);
		if (!content.exists()) {
			content.mkdir();
		}

		Iterator<String> iterator = request.getFileNames();
		String content_photo = null;

		dto.setContent_photo(content_photo);
		List<String> name = new ArrayList<String>();

		while (iterator.hasNext()) {
			String flTagNm = iterator.next();
			List<MultipartFile> flLst = request.getFiles(flTagNm);
			for (MultipartFile file : flLst) {
				System.out.println("업로드 성공");
				content_photo = uuid.toString() + file.getOriginalFilename();
				name.add(content_photo);
				try {
					file.transferTo(new File(filePath + content_photo));
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("업로드 중 오류!!!!!!!");
				}
			}
		}
		StringBuilder br = new StringBuilder();
		for (int i = 0; i < name.size(); i++) {
			if (i != name.size() - 1) {
				br.append(name.get(i) + " ");
			} else {
				br.append(name.get(i));
			}
		}
		dto.setContent_photo(br.toString());
		int res = biz.feedinsert(dto);

		return "redirect:home.do" + "#home";
	}

	@RequestMapping("/comment.do")
	@ResponseBody
	public Map<String, Integer> insertComment(@RequestBody ReDto dto) {
		logger.info("insert comment");

		int re_content_no = dto.getContentno();

		int content_comment_count = 0;
		content_comment_count = biz.commentCount(re_content_no); // 해당 게시글
																	// comment
																	// 갯수
		content_comment_count = content_comment_count + 1; // 게시글 comment 1 증가

		ContentDto content = null;
		content = new ContentDto();
		content.setContent_no(re_content_no);
		content.setContent_comment_count(content_comment_count);

		int res = biz.commentInsert(dto); // 댓글 입력
		int res_count = biz.countUpComment(content); // 게시글 댓글 갯수 1증가 업데이트

		if (res_count > 0) {
			System.out.println("수정완료");
		} else {
			System.out.println("수정 실패");
		}

		int updatecount = biz.searchCount(dto.getContentno());

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("count", updatecount);

		return map;

	}

	@RequestMapping("/detailComment.do")
	@ResponseBody
	public Map<String, ReDto> insertDetailComment(@RequestBody ReDto dto) {
		logger.info("insert detail comment");
		int re_content_no = dto.getContentno();

		int content_comment_count = 0;
		content_comment_count = biz.commentCount(re_content_no); // 해당 게시글
																	// comment
																	// 갯수
		content_comment_count = content_comment_count + 1; // 게시글 comment 1 증가

		ContentDto content = null;
		content = new ContentDto();
		content.setContent_no(re_content_no);
		content.setContent_comment_count(content_comment_count);

		int res = biz.detailCommentInsert(dto);
		int res_count = biz.countUpComment(content);

		if (res_count > 0) {
			System.out.println("수정 완료");
		} else {
			System.out.println("수정 실패");
		}

		String user_profile = null;

		Map<String, ReDto> map = new HashMap<String, ReDto>();

		List<ReDto> rdto = biz.listComment(dto.getContentno());
		int updatecount = biz.searchCount(dto.getContentno());

		rdto.get(rdto.size() - 1).setCount(updatecount);
		user_profile = biz.userprofile(rdto.get(rdto.size() - 1).getUserid());
		rdto.get(rdto.size() - 1).setRe_userprofile(user_profile);

		map.put("rdto", rdto.get(rdto.size() - 1));

		return map;
	}

	// timeline.jsp 검색탭에서 검색했을떄 처리
	// @RequestMapping(value = "/search.do", method = RequestMethod.POST)
	// @ResponseBody
	// public Map<String, List<ContentDto>> search(HttpSession session,
	// HttpServletRequest request, @RequestBody String keyword) {
	// Map<String, List<ContentDto>> map = new HashMap<String,
	// List<ContentDto>>();
	// List<ContentDto> searchList = null;
	// logger.info("SEARCH");
	// searchList = biz.searchList(keyword);
	//
	// List<String> imagesearch = null;
	// StringTokenizer st = null;
	// for (int i = 0; i < searchList.size(); i++) {
	// imagesearch = null;
	// imagesearch = new ArrayList<String>();
	// st = new StringTokenizer(searchList.get(i).getContent_photo(), " ");
	//
	// while (st.hasMoreTokens()) {
	// imagesearch.add(st.nextToken());
	// } ;
	// searchList.get(i).setContent_photo(imagesearch.get(0));
	// }
	//
	// map.put("searchList", searchList);
	// return map;
	// }
	// timeline에서 해시태그를 검색했을때 처리
	@RequestMapping(value = "/search.do")
	public String search(HttpServletRequest request, Model model,
			String keyword) {
		if (keyword.contains("#")) {
			List<ContentDto> searchList = biz.searchList(keyword);
			int tagcount = biz.tagcount(keyword);
			System.out.println("search keyword: " + keyword);
			List<String> hash = new ArrayList<String>();
			List<List<String>> hashlist = new ArrayList<List<String>>();
			StringTokenizer st = null;
			for (int i = 0; i < searchList.size(); i++) {
				hash = null;
				hash = new ArrayList<String>();
				st = new StringTokenizer(searchList.get(i).getContent_hashtag(),
						"#");

				while (st.hasMoreTokens()) {
					hash.add(st.nextToken().trim());
				}

				hashlist.add(hash);
			}
			List<String> image = null;
			List<List<String>> imageList = new ArrayList<List<String>>();
			StringTokenizer st2 = null;
			for (int i = 0; i < searchList.size(); i++) {
				image = null;
				image = new ArrayList<String>();
				st2 = new StringTokenizer(searchList.get(i).getContent_photo(),
						" ");

				while (st2.hasMoreTokens()) {
					image.add(st2.nextToken());
				}

				imageList.add(image);

			}
			String hashtag = "";
			String[] hashtaglist = {};
			for (ContentDto dto : searchList) {
				hashtag = dto.getContent_hashtag();
				hashtaglist = hashtag.split(" ");
				System.out.println("hashtag : " + hashtag);
				for (String str : hashtaglist) {
					System.out.println("str : " + str);
				}
			}
			model.addAttribute("allList", searchList);
			model.addAttribute("hashlist_search", hashlist);
			model.addAttribute("imageList", imageList);
			model.addAttribute("keyword", keyword);
			model.addAttribute("tagcount", tagcount);

			return "hashtagsearch";
		} else {
			UsersDto dto = null;
			dto = Lbiz.userinfo(keyword);
			if (dto == null) {
				return "hashtagsearch";
			} else {
				return "redirect:friendmypage.do?content_users_id=" + keyword;
			}
		}

	}

	// 해시태그를 눌렀을떄 처리
	@RequestMapping("/hashtagsearch.do")
	public String hashtagSearch(HttpServletRequest request, Model model,
			String keyword) {
		List<ContentDto> searchList = biz.searchList("#" + keyword);
		int tagcount = biz.tagcount("#" + keyword);
		List<String> hash = new ArrayList<String>();
		List<List<String>> hashlist = new ArrayList<List<String>>();
		StringTokenizer st = null;

		for (int i = 0; i < searchList.size(); i++) {
			hash = null;
			hash = new ArrayList<String>();
			st = new StringTokenizer(searchList.get(i).getContent_hashtag(),
					"#");

			while (st.hasMoreTokens()) {
				hash.add(st.nextToken().trim());
			} ;

			hashlist.add(hash);
		}
		List<String> image = null;
		List<List<String>> imageList = new ArrayList<List<String>>();
		StringTokenizer st2 = null;
		for (int i = 0; i < searchList.size(); i++) {
			image = null;
			image = new ArrayList<String>();
			st2 = new StringTokenizer(searchList.get(i).getContent_photo(),
					" ");

			while (st2.hasMoreTokens()) {
				image.add(st2.nextToken());
			}

			imageList.add(image);

		}

		model.addAttribute("allList", searchList);
		model.addAttribute("hashlist_search", hashlist);
		model.addAttribute("imageList", imageList);
		model.addAttribute("keyword", "#" + keyword);
		model.addAttribute("tagcount", tagcount);
		return "hashtagsearch";
	}

	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> deleteComment(@RequestBody ReDto redto) {
		System.out.println("실행");
		int res = 0;
		int res2 = 0;
		int re_no = redto.getRe_no();
		int content_no = 0;
		content_no = redto.getContentno();

		int count = biz.searchCount(content_no);
		count = count - 1;

		ContentDto dto = new ContentDto();
		dto.setContent_no(content_no);
		dto.setContent_comment_count(count);

		res = biz.deleteComment(re_no);
		res2 = biz.countUpComment(dto);

		if (res > 0) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
		}

		Map<String, Integer> map = null;
		map = new HashMap<String, Integer>();
		map.put("count", count);

		return map;
	}

	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> saveContent(HttpSession session,
			@RequestBody String content) {
		System.out.println("실행");
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		int content_no = Integer.parseInt(content);

		ContentDto cdto = biz.weather(content_no);

		SaveDto sdto = new SaveDto();
		sdto.setSave_content_no(cdto.getContent_no());
		sdto.setSave_content_photo(cdto.getContent_photo());
		sdto.setSave_content_substance(cdto.getContent_substance());
		sdto.setSave_content_place_name(cdto.getContent_place_name());
		sdto.setSave_content_place_lat(cdto.getContent_place_lat());
		sdto.setSave_content_place_lon(cdto.getContent_place_lon());
		sdto.setSave_content_users_id(cdto.getContent_users_id());
		sdto.setSave_content_hashtag(cdto.getContent_hashtag());
		sdto.setSave_content_date(cdto.getContent_date());
		sdto.setSave_user_id(users_id);

		int res = biz.saveContent(sdto);
		if (res > 0) {
			System.out.println("저장성공");
		} else {
			System.out.println("저장 실패");
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("성공", "성공");

		return map;
	}

	@RequestMapping("/savepage.do")
	public String savePage(HttpSession session, Model model) {
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		List<SaveDto> saveList = null;
		saveList = biz.saveList(users_id);

		List<String> hash = null;
		List<List<String>> hashList = new ArrayList<List<String>>();
		StringTokenizer st = null;

		for (int i = 0; i < saveList.size(); i++) {
			hash = null;
			hash = new ArrayList<String>();
			st = new StringTokenizer(saveList.get(i).getSave_content_hashtag(),
					"#");

			while (st.hasMoreElements()) {
				hash.add(st.nextToken());
			}

			hashList.add(hash);
		}

		List<String> img = null;
		List<List<String>> imgList = new ArrayList<List<String>>();
		StringTokenizer st2 = null;

		for (int i = 0; i < saveList.size(); i++) {
			img = null;
			img = new ArrayList<String>();
			st2 = new StringTokenizer(saveList.get(i).getSave_content_photo(),
					" ");

			while (st2.hasMoreTokens()) {
				img.add(st2.nextToken());
			}

			imgList.add(img);
		}

		model.addAttribute("saveList", saveList);
		model.addAttribute("hashList", hashList);
		model.addAttribute("imgList", imgList);

		return "savepage";
	}

	@RequestMapping("/friend.do")
	@ResponseBody
	public Map<String, List<String>> friend(@RequestBody String userid) {
		List<FollowDto> followingList = biz.followingList(userid);
		List<FollowDto> recommendList = null;
		recommendList = biz.recommendList(userid);

		List<String> rList = null;

		rList = new ArrayList<String>();
		// 추천친구목록에서 내 친구를 제거
		for (int i = 0; i < followingList.size(); i++) {
			for (int j = 0; j < recommendList.size(); j++) {
				if (followingList.get(i).getFollow_target()
						.equals(recommendList.get(j).getFollow_target())) {
					recommendList.get(j).setFollow_target("");
				}
			}
		}
		// 추천친구 목록에서 나를 제거
		for (int i = 0; i < recommendList.size(); i++) {
			if (recommendList.get(i).getFollow_target().equals(userid)) {
				recommendList.get(i).setFollow_target("");
			}
		}
		Set<String> set = new HashSet<String>();
		// 추천목록에 추가
		for (int i = 0; i < recommendList.size(); i++) {
			if (!recommendList.get(i).getFollow_target().equals("")) {
				set.add(recommendList.get(i).getFollow_target());
				rList.add(recommendList.get(i).getFollow_target());
			}
		}
		List<String> tmp = new ArrayList<String>(set);

		List<String> profile = null;
		profile = new ArrayList<String>();

		for (int i = 0; i < rList.size(); i++) {
			profile.add(biz.userprofile(tmp.get(i)));
		}

		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("rList", tmp);
		map.put("imgList", profile);

		return map;
	}

	@RequestMapping(value = "/recommendfollow.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> recommendfollow(@RequestBody String target,
			HttpSession session) {
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String user_id = null;
		user_id = dto.getUsers_id();

		FollowDto fdto = new FollowDto(user_id, target);

		int res = biz.followinsert(fdto);

		if (res > 0) {
			System.out.println("성공");
		} else {
			System.out.println("실패");
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("성공", "성공");

		return map;
	}

	// 자동완성 기능 users_id & #태그명으로 검색
	@RequestMapping(value = "/autocomplete.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<Integer, String> autocomplete(@RequestBody String keyword) {
		// Response할 map 선언
		Map<Integer, String> map = new HashMap<Integer, String>();
		// 해쉬태그의 중복 기입을 제거하기위해 value가 unique인 Set 사용
		Set<String> set = new HashSet<String>();
		// 클라이언트로부터 자동완성으로 요청이 들어오게 되면 keyword값으로 검색후 포함되는 태그를 가져옴
		List<ContentDto> autocomplete = biz.autocomplete(keyword);
		//
		if (keyword.contains("#")) {
			String hashtag = "";
			String[] hashlist = {};
			ArrayList<String> hashtaglist = new ArrayList<String>();
			for (ContentDto dto : autocomplete) {
				hashtag = dto.getContent_hashtag().replaceAll("#", "");
				// hashlist에는 공백문자를 제외한 #태그가 담김
				hashlist = hashtag.split(" ");
				String keyword2 = keyword.replaceAll("#", "");
				for (String str : hashlist) {
					// hashlist를 str로 돌면서 keyword가 포함됐다면 모두 hashtaglist에 추가
					if (str.contains(keyword2)) {
						hashtaglist.add(str);
					}
				}
				// 중복이 제거된채로 hashtaglist의 태그들이 담김
				set.addAll(hashtaglist);
			}
			// set을 iterator로 뽑기
			Iterator<String> setIter = set.iterator();
			// map에 set을 추가후 반환
			int i = 0;
			while (setIter.hasNext()) {
				map.put(i++, setIter.next());
			}
		} else {
			keyword.replaceAll("#", "");

			List<UsersDto> userList = Lbiz.userList(keyword);

			for (int key = 0; key < userList.size(); key++) {
				map.put(key, userList.get(key).getUsers_id());
			}

		}
		return map;
	}

	@RequestMapping("/savedelete.do")
	public String savedelete(int content_no, HttpSession session) {
		int save_content_no = content_no;

		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		SaveDto save = new SaveDto();
		save.setSave_content_no(save_content_no);
		save.setSave_user_id(users_id);

		int res = biz.savedelete(save);

		return "redirect:savepage.do?";
	}

	@RequestMapping(value = "/savedeleteajax.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> savedeleteajax(@RequestBody String content,
			HttpSession session) {
		int save_content_no = Integer.parseInt(content);

		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		SaveDto save = new SaveDto();
		save.setSave_content_no(save_content_no);
		save.setSave_user_id(users_id);

		int res = biz.savedelete(save);

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", res);

		return map;
	}

	@RequestMapping(value = "/live.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<LiveDto>> live(@RequestBody String live) {
		int res = 0;

		String profile = biz.userprofile(live);

		LiveDto dto = new LiveDto();
		dto.setLive_user_id(live);
		dto.setLive_user_profile(profile);

		res = biz.live(dto);

		List<LiveDto> livelist = biz.liveList();

		Map<String, List<LiveDto>> map = new HashMap<String, List<LiveDto>>();
		map.put("livelist", livelist);

		return map;
	}

	@RequestMapping(value = "/livestop.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<LiveDto>> livestop(@RequestBody String live) {
		int res = 0;

		res = biz.livestop(live);

		List<LiveDto> livelist = biz.liveList();

		Map<String, List<LiveDto>> map = new HashMap<String, List<LiveDto>>();
		map.put("livelist", livelist);

		return map;
	}

	@RequestMapping(value = "/openchat.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> openchatcreate(@RequestBody OpenchatDto dto) {
		int res = 0;

		res = biz.openchatCreate(dto);

		Map<String, String> map = new HashMap<String, String>();
		if (res != 0) {
			map.put("res", "success");
		} else {
			map.put("res", "false");
		}

		return map;
	}

	@RequestMapping(value = "/openchatinsert.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> openchatinsert(@RequestBody MyOpenchatDto dto) {
		int res = 0;

		res = biz.openchatinsert(dto);

		Map<String, String> map = new HashMap<String, String>();
		map.put("res", "sucess");

		return map;
	}

	@RequestMapping(value = "/openchatsubstane.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<OpenchatsubDto>> openchatsubstane(
			@RequestBody String openname) {
		System.out.println(openname);
		List<OpenchatsubDto> dto = null;

		dto = mbiz.openchatsub(openname);

		Map<String, List<OpenchatsubDto>> map = new HashMap<String, List<OpenchatsubDto>>();
		map.put("list", dto);

		for (int i = 0; i < dto.size(); i++) {
			System.out.println(dto.get(i).toString());
		}

		return map;
	}

	@RequestMapping("/dm.do")
	public String dm(HttpServletRequest request, HttpSession session) {

		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		List<DmDto> dmlist = null;
		dmlist = biz.dmlistall(users_id);
		ArrayList<String> receiverlist = new ArrayList<String>();

		for (int i = 0; i < dmlist.size(); i++) {
			receiverlist.add(dmlist.get(i).getDm_receiver());
		}

		String dm_receiver = request.getParameter("dmreceive");

		DmDto ddto = new DmDto();

		ddto.setDm_user_id(users_id);
		ddto.setDm_receiver(dm_receiver);

		if (receiverlist.contains(dm_receiver)) {
			String status = null;
			String restatus = null;

			status = biz.dmstatus(ddto);
			restatus = biz.dmrestatus(ddto);
			if (status.equals("N")) {
				int update = 0;
				update = biz.dmstatusupdate(ddto);
			}
			if (restatus.equals("N")) {
				int update = 0;
				update = biz.dmrestatusupdate(ddto);
			}

			return "redirect:ms.do" + "#work";
		} else {

			int res = 0;

			res = biz.dminsert(ddto);

			return "redirect:ms.do" + "#work";
		}
	}

	@RequestMapping(value = "/openchatexit.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> openchatexit(@RequestBody String openname,
			HttpSession session) {
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();

		MyOpenchatDto mdto = new MyOpenchatDto();
		mdto.setOpenname(openname);
		mdto.setUserid(users_id);

		int res = 0;

		res = biz.openchatexit(mdto);

		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "result");

		return map;
	}

	@RequestMapping(value = "/dmsubstance.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<DmsubDto>> dmsubstance(@RequestBody DmDto dto) {
		List<DmsubDto> dmsubdto = null;

		dmsubdto = mbiz.dmsub(dto);

		Map<String, List<DmsubDto>> map = new HashMap<String, List<DmsubDto>>();

		map.put("list", dmsubdto);

		return map;
	}

	@RequestMapping(value = "/dmexit.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> dmexit(@RequestBody String roomname,
			HttpSession session) {

		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();
		int dm_no = Integer.parseInt(roomname);

		DmDto ddto = new DmDto();
		ddto.setDm_no(dm_no);
		ddto.setDm_user_id(users_id);

		int res = 0;
		res = biz.dmexit(ddto);

		Map<String, String> map = new HashMap<String, String>();
		map.put("res", "success");
		return map;
	}

	@RequestMapping(value = "/newdmstatusupdate.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> newdmstatusupdate(@RequestBody DmDto dto) {

		int res = 0;

		res = biz.newdmstatusupdate(dto);

		return null;

	}
}
