package auth;

import java.io.IOException;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReservationDto;
import reservation.ReservationService;

/**
 * Servlet implementation class AuthRevServ
 */
@WebServlet("/authRev")
public class AuthReservServlet extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String command = req.getParameter("command");
		System.out.println(command);
		
		ReservationService rService = new ReservationService();
		List<ReservationDto> list = rService.getAllCurRev();
		
		//Calendar cal = Calendar.getInstance();
		//int todayDate = cal.get(Calendar.DATE);
		//System.out.println("todayDate: " + todayDate);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date currentTime = new Date();
		String current = format.format(currentTime);
		try {
			Date today = format.parse(current);
		
		
		if(command.equals("curRev")) {
			
			List<ReservationDto> curList = new ArrayList<ReservationDto>();
			for (int i = 0; i < list.size(); i++) {
				//int rday = Integer.parseInt(list.get(i).getRdate().substring(8, 10));
				String rDay =list.get(i).getRdate();
					Date formattedRDay = format.parse(rDay);
					
				if(formattedRDay.compareTo(today) > -1) {
	 				curList.add(list.get(i));			
				}
				
			}
			
			req.setAttribute("curList", curList);
			forward("curRevList.jsp", req, resp);
			
		}else if(command.equals("pastRev")) {
			List<ReservationDto> pastList = new ArrayList<ReservationDto>();
			for (int i = 0; i < list.size(); i++) {
				String rDay =list.get(i).getRdate();
				Date formattedRDay = format.parse(rDay);

				if(formattedRDay.compareTo(today) == -1) {
					pastList.add(list.get(i));			
				}
			}
			req.setAttribute("pastList", pastList);
			forward("pastRevList.jsp", req, resp);
			
		}
		
		} catch (ParseException e) {
			System.out.println("format exception!!");
			e.printStackTrace();
		}
		
	}
	
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(link);
		dispatch.forward(req, resp);
	}

}
