package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	private Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value = "index")
	public String Index() {
		log.info(this.getClass());
		return "/user/login";
	}

	@RequestMapping(value = "main")
	public String main() {
		return "/main";
	}


	@RequestMapping(value = "/menu")
	public String menu() {
		return "/menu/menuPage";
	}

	@RequestMapping(value = "/menuTest")
	public String menuTest(){
		return "/menu/menuPage_test";
	}
}
