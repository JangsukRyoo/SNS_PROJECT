package com.tt.sns;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

import com.tt.sns.model.biz.LoginBiz;
import com.tt.sns.model.biz.MariaBiz;
import com.tt.sns.model.biz.TimelineBiz;
import com.tt.sns.model.dto.UsersDto;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory
			.getLogger(LoginController.class);

	@Autowired
	private LoginBiz biz;
	@Autowired
	private MariaBiz mbiz;
	@Autowired
	private TimelineBiz tbiz;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@RequestMapping("/signin.do")
	public String signIn() {
		logger.info("SIGN IN");
		return "sign-in";
	}
	// 로그인
	@RequestMapping(value = "/ajaxlogin.do", method = RequestMethod.POST)
	   @ResponseBody
	   public Map<String, Boolean> ajaxLogin(HttpSession session,
	         @RequestBody UsersDto dto) {
	      logger.info("AJAX LOGIN");
	      UsersDto login = biz.login(dto);
	      boolean check = false;
	      if (login != null) {
	         if (passwordEncoder.matches(dto.getUsers_pw(),
	               login.getUsers_pw())) {
	            session.setAttribute("login", login);
	            session.setAttribute("user_profile", login.getUsers_profile());
	            check = true;
	         }
	      }

	      Map<String, Boolean> map = new HashMap<String, Boolean>();
	      map.put("check", check);
	      return map;
	   }
	// 회원가입 폼 요청
	@RequestMapping("/signup.do")
	public String signUp(UsersDto dto) {
		logger.info("SIGN UP");
		return "sign-up";
	}

	// 아이디 중복확인
	@RequestMapping(value = "/idChk.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> idChk(@RequestBody UsersDto dto) {
		logger.info("idChk");
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		boolean valid = false;
		UsersDto res = biz.login(dto);
		if (res == null) {
			valid = true;
		}
		map.put("chk", valid);
		return map;
	}
	// 폰번호 중복 확인
	@RequestMapping(value = "/phonechk.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> phoneChk(@RequestBody String users_phone) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		boolean valid = false;
		UsersDto res = biz.phoneChk(users_phone);
		if (res == null) {
			valid = true;
		}
		map.put("chk", valid);
		return map;
	}

	// 회원가입
	@RequestMapping("/signupres.do")
	public String signUpRes(UsersDto dto, MultipartHttpServletRequest request,
			BindingResult result) {
		logger.info("SIGN UP RES");

		// 추가
		UUID uuid = UUID.randomUUID();
		MultipartFile file = dto.getMpfile();
		String users_profile = file.getOriginalFilename();
		if (users_profile != "") {
			users_profile = uuid.toString() + file.getOriginalFilename();
		}
		System.out.println(users_profile);

		UsersDto fileObj = new UsersDto();
		fileObj.setUsers_profile(users_profile);

		InputStream inputstream = null;
		OutputStream outputstream = null;

		if (users_profile != "") {
			try {
				inputstream = file.getInputStream();
				// 폴더와 파일 만듦
				// String path = request.getRealPath("resources/images");
				String path = WebUtils.getRealPath(
						request.getSession().getServletContext(),
						"/resources/images/profile");

				System.out.println("업로드 될 실제 경로 : " + path);

				// 경로 없으면 만들자
				File storage = new File(path);
				if (!storage.exists()) {
					storage.mkdir();
				}

				File newFile = new File(path + "/" + users_profile);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}

				outputstream = new FileOutputStream(newFile);

				int read = 0;
				byte[] b = new byte[(int) file.getSize()];

				while ((read = inputstream.read(b)) != -1) {
					outputstream.write(b, 0, read);
				}

			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					inputstream.close();
					outputstream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}

				// 추가

			}
		}

		dto.setUsers_profile(users_profile);
		dto.setUsers_pw(passwordEncoder.encode(dto.getUsers_pw()));

		if (users_profile != "") {

			if (biz.insert(dto) > 0) {
				mbiz.insert(dto);
				return "redirect:signin.do";
			} else {
				return "redirect:signup.do";
			}

		} else {
			if (biz.insert2(dto) > 0) {
				mbiz.insert2(dto);
				return "redirect:signin.do";
			} else {
				return "redirect:signup.do";
			}
		}

	}
	// 로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		logger.info("logout");
		UsersDto dto = null;
		dto = (UsersDto) session.getAttribute("login");
		String users_id = null;
		users_id = dto.getUsers_id();
		
		int res = 0;
		
		res = tbiz.livestop(users_id);
		
		session.invalidate();
		return "redirect:signin.do";
	}
	// 프로필업로드
	@RequestMapping("/profileupdate.do")
	   public String profileupdate(UsersDto dto,
	         MultipartHttpServletRequest request, BindingResult result, HttpSession session) {
	      UsersDto userdto = null;
	      userdto = (UsersDto) session.getAttribute("login");
	      String users_id = null;
	      users_id = userdto.getUsers_id();
	      
	      UsersDto oldDto = biz.userinfo(users_id);
	      
	      UUID uuid = UUID.randomUUID();
	      MultipartFile file = dto.getMpfile();
	      String users_profile = file.getOriginalFilename();
	      if (users_profile.equals("") || users_profile.equals(null)) {
	         users_profile = oldDto.getUsers_profile();
	      }else {
	         users_profile = uuid.toString() + file.getOriginalFilename();
	         UsersDto fileObj = new UsersDto();
	         fileObj.setUsers_profile(users_profile);
	         

	         InputStream inputstream = null;
	         OutputStream outputstream = null;

	         if (users_profile != "") {
	            try {
	               inputstream = file.getInputStream();
	               // 폴더와 파일 만듦
	               // String path = request.getRealPath("resources/images");
	               String path = WebUtils.getRealPath(
	                     request.getSession().getServletContext(),
	                     "/resources/images/profile/");

	               System.out.println("업로드 될 실제 경로 : " + path);

	               // 경로 없으면 만들자
	               File storage = new File(path);
	               if (!storage.exists()) {
	                  storage.mkdir();
	               }

	               File newFile = new File(path + "/" + users_profile);
	               if (!newFile.exists()) {
	                  newFile.createNewFile();
	               }

	               outputstream = new FileOutputStream(newFile);

	               int read = 0;
	               byte[] b = new byte[(int) file.getSize()];

	               while ((read = inputstream.read(b)) != -1) {
	                  outputstream.write(b, 0, read);
	               }

	            } catch (IOException e) {
	               e.printStackTrace();
	            } finally {
	               try {
	                  inputstream.close();
	                  outputstream.close();
	               } catch (IOException e) {
	                  e.printStackTrace();
	               }
	            }
	      }
	      System.out.println(users_profile);
	      }

	      dto.setUsers_profile(users_profile);
	      if ((!dto.getUsers_pw().equals("")) && dto.getUsers_pw() != null) {
	         dto.setUsers_pw(passwordEncoder.encode(dto.getUsers_pw()));
	      } else {
	         UsersDto user = biz.login(dto);
	         dto.setUsers_pw(user.getUsers_pw());
	      }
	      int res =biz.profileupdate(dto);
	      session.setAttribute("user_profile", users_profile);

	      if(res>0) {
	      return "redirect:home.do" + "#home";
	      }else {
	         return "redirect:home.do";
	      }
	   }
	// 계정 정보 찾기 페이지
	@RequestMapping("/forgot.do")
	public String forgot() {
		return "forgot";
	}

	// 계정 정보 가져오기
	@RequestMapping("/findaccount.do")
	@ResponseBody
	public Map<String, UsersDto> findAccount(@RequestBody UsersDto dto) {
		Map<String, UsersDto> map = new HashMap<String, UsersDto>();
		logger.info("Find ID");
		UsersDto res = biz.findAccount(dto);
		map.put("user", res);
		return map;
	}

	// 비밀번호 수정 페이지
	@RequestMapping("/editpwform.do")
	public String editForm(Model model, String users_id) {
		model.addAttribute("users_id", users_id);
		return "editpw";
	}
	// 비밀번호 수정후 처리 페이지
	@RequestMapping("/editpw.do")
	public String editPw(UsersDto dto) {
		int res = 0;
		dto.setUsers_pw(passwordEncoder.encode(dto.getUsers_pw()));
		res = biz.editPw(dto);
		int res2 = 0;
		res2 = mbiz.editPw(dto);
		if (res > 0) {
			return "redirect:signin.do";
		} else {
			return "redirect:forgot.do";
		}
	}
	
	@RequestMapping("/relogin.do")
	public String relogin() {
		return "relogin";
	}

}
