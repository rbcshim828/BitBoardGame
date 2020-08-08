package MainAndNotice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/noticeDelete")
public class NoticeDeleteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processFunction(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processFunction(req, resp);
	}
	
	public void processFunction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// delete �� �ʿ��� seq ��������!
		String sseq = req.getParameter("seq");
		int seq = Integer.parseInt(sseq);
		
		// singleton
		NoticeDAO dao = NoticeDAO.getInstance();
		
		boolean isS = dao.deleteNotice(seq);
		
		System.out.println("�������� isS = " + isS);
		resp.sendRedirect("noticeDelete.jsp?command=deleteAf&isS="+isS);
	}

}