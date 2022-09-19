package com.allmate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/admin/AdminActionServlet")
public class AdminActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement pstmt = null;
	 	String type = request.getParameter("type");
	 	
	 	try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	 	
	 				
		if(type.equals("addFlight")) {			
			String [] arr = {"id", "flightName", "fromCity", "toCity", "date", "airportName", "price", "description"};
			String query = "insert into flight values (?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				pstmt = conn.prepareStatement(query);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			for(int i = 1; i <= arr.length; i++) {
				try {									
					pstmt.setString(i, request.getParameter(arr[i - 1]));
				} catch (SQLException e) {
					e.printStackTrace();
				}	
			}
			try {
				pstmt.execute();
				JSONObject json = null;
				Map<String, Boolean> map = new HashMap<String, Boolean>();
				if(pstmt.getUpdateCount() > 0) {					
					map.put("success", true);							
				}else {
					map.put("success", false);		
				}
				json = new JSONObject(map);
				response.getWriter().println(json);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		if(type.equals("search")) {
			String query = "select * from flight where id = ? and flightName = ?";
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, request.getParameter("id"));
				pstmt.setString(2, request.getParameter("flightName"));
				ResultSet rs = pstmt.executeQuery();
				String output = "";
				
				while(rs.next()) {					
					String id = rs.getString("id");
			 		String flightName = rs.getString("flightName");
			 		String fromCity = rs.getString("fromCity");
			 		String toCity = rs.getString("toCity");
			 		String flightDate = rs.getString("flightDate");
			 		String[] parts = flightDate.split(" ");
			 		String airportName = rs.getString("airportName");
			 		String price = rs.getString("price");
			 		String description = rs.getString("description");
			 		String rowId = "flight-row-" + id;
			 		String bookBtn = String.format("<button class=\"btn btn-info btn-small edit-btn\" id=\"%s\">Edit</button>", rowId);
			 				
			 		output += String.format(
			 				"<tr id=\"row-%s\">" +
			 					"<td><div class=\"form-check\"><input class=\"form-check-input\" type=\"checkbox\" name=\"row-check\" value=\"cb-%s\"></div></td>" +
				 				"<td>%s</td>" + "<td>%s</td>" + 
				 			    "<td>%s</td>" + "<td>%s</td>" + 
				 				"<td>%s</td>" + "<td>%s</td>" + 
				 			    "<td>%s</td>" + "<td>%s</td>" + 
				 				"<td>%s</td>" + "<td>%s</td>" +
			 			    "</tr>",
			 				id, id, id, flightName, fromCity, toCity, parts[0], parts[1], 
			 				airportName, price, description,bookBtn);
				}
				response.getWriter().println(output);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if(type.equals("edit")) {
			String [] arr = {"flightName", "fromCity", "toCity", "date", "airportName", "price", "description", "id"};
			String query = 
					"update flight set flightName=?, fromCity=?, toCity=?, flightDate=?,airportName=?, price=?, description=? where id = ?";
			try {
				pstmt = conn.prepareStatement(query);
				for(int i = 1; i <= arr.length; i++) {					
					pstmt.setString(i, request.getParameter(arr[i - 1]));
				}
				pstmt.execute();
				JSONObject json = null;
				Map<String, Boolean> map = new HashMap<String, Boolean>();
				
				if(pstmt.getUpdateCount() > 0) {
					map.put("success", true);	
				}else {
					map.put("success", false);	
				}
				json = new JSONObject(map);
				response.getWriter().println(json);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if(type.equals("delete")) {
			String idStr = request.getParameter("idKeys");
			String [] idKeys = idStr.split("-");
			String tempStr = "delete from flight where id in(";
			
			for(int i = 0; i < idKeys.length; i++) {
				tempStr += "?,";
			}
			
			String query = tempStr.substring(0, tempStr.length() - 1) + ")";
			try {
				pstmt = conn.prepareStatement(query);
				for(int i = 0; i < idKeys.length; i++) {
					pstmt.setString(i + 1, idKeys[i]);
				}
				
				JSONObject json = null;
				Map<String, Boolean> map = new HashMap<String, Boolean>();
				
				if(pstmt.executeUpdate() == idKeys.length) {
					map.put("success", true);
				}else {
					map.put("success", false);
				}
				
				json = new JSONObject(map);
				
				response.getWriter().println(json);
			
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
