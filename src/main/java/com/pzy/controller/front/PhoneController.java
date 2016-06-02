package com.pzy.controller.front;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pzy.entity.Category;
import com.pzy.entity.Project;
import com.pzy.entity.User;
import com.pzy.service.CategoryService;
import com.pzy.service.ProjectService;
import com.pzy.service.UserService;
/***
 * 前台，首页各种连接登陆等
 * @author qq:263608237
 *
 */
@Controller
@RequestMapping("/phone")
public class PhoneController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ProjectService projectService;
	
	
	@InitBinder  
	protected void initBinder(HttpServletRequest request,   ServletRequestDataBinder binder) throws Exception {   
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true)); 
	}  
	/***
	 * 跳转到首页
	 * @param model
	 * @return
	 */
	@RequestMapping("index")
	public String index(Model model,HttpSession httpSession) {
		httpSession.setAttribute("user", userService.find(1l));
		return "phone/index";
	}
	
	@RequestMapping("project")
	public String project(Model model,HttpSession httpSession) {
		model.addAttribute("projects",projectService.findTop3());
		return "phone/project";
	}
	@RequestMapping("upload")
	public String upload(Model model,HttpSession httpSession) {
		User user=(User)httpSession.getAttribute("user");
		if(user==null){
			model.addAttribute("tip","请登陆！");
			return "phone/login";
		}
		model.addAttribute("projects",projectService.findByUser(user));
		return "phone/upload";
	}
	@RequestMapping("doupload")
	public String doupload(@RequestParam(value = "uploadfile", required = false) MultipartFile file, Project project, Model model,HttpSession httpSession) {
		  System.out.println("开始");  
	        String path = httpSession.getServletContext().getRealPath("/upload");  
	        String fileName = file.getOriginalFilename();  
	        System.out.println(path);  
	        File targetFile = new File(path, fileName);  
	        if(!targetFile.exists()){  
	            targetFile.mkdirs();  
	        }  
	        //保存  
	        try {  
	            file.transferTo(targetFile);  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        project.setImg(fileName);
	        User user=(User)httpSession.getAttribute("user");
	        project.setUser(user);
	        projectService.save(project);
			model.addAttribute("projects",projectService.findByUser(user));
		return "phone/upload";
	}
	@RequestMapping("about")
	public String about(Model model) {
		return "phone/about";
	}
	
	
	
	@RequestMapping("rate")
	public String rate(Model model) {
		return "phone/discuss";
	}
	@RequestMapping("customer")
	public String customer(Model model) {
		return "phone/customer";
	}
	@RequestMapping("category")
	public String category(Model model,Long id) {
		return "phone/category";
	}
	@RequestMapping("movie")
	public String movie(Model model,Long id) {
		model.addAttribute("projects",projectService.findTop3());
		return "phone/movie";
	}
	@RequestMapping("searchProject")
	public String searchProject(Model model,String key) {
		model.addAttribute("search",true);
		model.addAttribute("projects",projectService.findByName(key));
		return "phone/project"; 
	}
	
	@RequestMapping("viewmovie")
	public String viewmovie(Model model,Long id) {
		model.addAttribute("project",projectService.find(id));
		model.addAttribute("usernum",categoryService.findByProject(projectService.find(id)).size());
		model.addAttribute("msgs",categoryService.findByProject(projectService.find(id)));
		return "phone/viewmovie";
	}
	@RequestMapping("msgadd")
	public String msgadd(Model model,Category category ,HttpSession httpSession,RedirectAttributes redirectAttributes) {
		User user=(User)httpSession.getAttribute("user");
		if(user==null){
			model.addAttribute("tip","请登陆！");
			return "phone/login";
		}
		category.setUser(user);
		category.setCreateDate(new Date());
		
		
		Project project = projectService.find(category.getProject().getId());
		project.setScore(categoryService.getAvg(project.getId()));
		projectService.save(project);
		categoryService.save(category);
		model.addAttribute("tip","评论成功");
		redirectAttributes.addFlashAttribute("tip", "Successfully added..");
		return "redirect:/phone/viewmovie?id="+category.getProject().getId();
	}
	

	
	
	
	@RequestMapping("center")
	public String center(Model model,HttpSession httpSession) {
		User user=(User) httpSession.getAttribute("user");
		if(user==null){
			model.addAttribute("tip","请登陆！");
			return "phone/login";
		}
		model.addAttribute("user",user);
		return "phone/center";
		
	}
	
	@RequestMapping("store")
	public String store(Model model,HttpSession httpSession,Long id) {
		return "phone/store";
	}
	@RequestMapping("loginout")
	public String loginout(HttpSession httpSession,Model model) {
		httpSession.removeAttribute("user");
		model.addAttribute("tip","已注销！");
		return "phone/login";
	}
	
	/***
	 * 点击注册
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping("doregister")
	public String register(User user,Model model) {
		user.setCreateDate(new Date());
		model.addAttribute("tip","注册成功请登录！");
		userService.save(user);
		return "phone/login";
	}
	@RequestMapping("login")
	public String login(Model model) {
		return "phone/login";
	}
	@RequestMapping("register")
	public String register(Model model) {
		return "phone/register";
	}
	@RequestMapping("dologin")
	public String dologin(User user,HttpSession httpSession,Model model) {
		User loginuser=userService.login(user.getUsername(), user.getPassword());
    	if(loginuser!=null){
    		httpSession.setAttribute("user", loginuser);
    		model.addAttribute("user",loginuser);
            return "phone/center"; 
    	}
    	else{
    		httpSession.removeAttribute("user");
    		model.addAttribute("tip","登陆失败 不存在此用户名或密码!");
    		return "phone/login";
    	}
	}
	
	/*@RequestMapping("myorder")
	public String myorder(HttpSession httpSession,Model model) {
		User user=(User)httpSession.getAttribute("user");
		model.addAttribute("orders",orderService.findByUser(user));
		return "phone/myorder";
	}*/
}

