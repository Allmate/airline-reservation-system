package com.allmate;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ActionServlet")
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
	 	Statement stmt = null;
		String type = request.getParameter("type");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
			stmt = conn.createStatement();		
		} catch (Exception e) {			
			e.printStackTrace();
		}
		
		if(type.equals("search")) {	
			String from = request.getParameter("from");
			String destincation = request.getParameter("destincation");
			String date = request.getParameter("date");
			String sql = String.format("select * from flight where fromCity='%s' and toCity='%s' and flightDate like '%s%%' and flightDate > now()", from, destincation, date);
			String output = "";
			
			
		 	try {
			 	ResultSet rs = stmt.executeQuery(sql);
			 	
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
			 		String bookBtn = String.format("<button class=\"btn btn-info btn-small order-btn\" id=\"%s\">Book</button>", rowId);
			 				
			 		output += String.format(
			 				"<td>%s</td>" + "<td>%s</td>" + 
			 			    "<td>%s</td>" + "<td>%s</td>" + 
			 				"<td>%s</td>" + "<td>%s</td>" + 
			 			    "<td>%s</td>" + "<td>%s</td>" + 
			 				"<td>%s</td>" + "<td>%s</td>"		
			 				,id, flightName, fromCity, toCity, parts[0], parts[1], 
			 				airportName, price, description,bookBtn);
			 	}
			 	response.getWriter().println(output);
			 	
			} catch (Exception e) { 
				System.out.println(e);
			}
		}
		
		if(type.equals("userLogin")) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String query = String.format("select * from user where email='%s' and password='%s'", email, password);
			Map<String, Object> map = new HashMap<>();
			JSONObject json = null;
			
			try {
				ResultSet rs = stmt.executeQuery(query);
				if(rs.next()) {
					map.put("success", true);
					map.put("userId", rs.getString("id"));
					json = new JSONObject(map);
				}else {
					map.put("success", false);
					json = new JSONObject(map);
				}
				
				response.getWriter().println(json);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		if(type.equals("adminLogin")) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");			
			String query = String.format("select * from admin where email='%s' and password='%s'", email, password);
			try {
				ResultSet rs = stmt.executeQuery(query);
				JSONObject json = null;
								
				if(rs.next()) {					
					Map<String, Object> map = new HashMap<>();
					map.put("success", true);										
					json = new JSONObject(map);							
				}else {
					Map<String, Boolean> map = new HashMap<String, Boolean>();					
					map.put("success", false);					
					json = new JSONObject(map);
				}
				response.getWriter().println(json);

			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}		
		
		if(type.equals("registration")) {			
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			JSONObject json = null;
			Map<String, Object> map = new HashMap<>();
			
			String query1 = "select * from user where email = '" + email + "'";
			
			String query2 = String.format("insert into user(firstName, lastName, email, password) values ('%s', '%s', '%s', '%s')",
										 firstName, lastName, email, password);			
			
			String query3 = String.format("select id from user where email = '%s'", email);
						
			try {
				ResultSet rs1 = stmt.executeQuery(query1); 
				
				// if email address already exists
				if(rs1.next()) {
					map.put("success", false);
					map.put("causeRoot", "duplicate email address");
					json = new JSONObject(map);
					response.getWriter().println(json);
					return;
				}
								
					stmt.execute(query2);
					ResultSet rs2 = stmt.executeQuery(query3);
					if(rs2.next()) {
						int userId = rs2.getInt(1);
						map.put("success", true);
						map.put("userId", userId);
						json = new JSONObject(map);
						response.getWriter().println(json);
					}																															
												
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if(type.equals("order")) {
			String email = request.getParameter("email");
			String phoneNumber = request.getParameter("phoneNumber");
			String noOfPerson = request.getParameter("noOfPerson");
			String address = request.getParameter("address");
			
			// check email existence in user table 			
			String query1 = String.format("select * from user where email = '%s'", email);
			Map<String, Object> map = new HashMap<>();
			
			try {
				ResultSet rs = stmt.executeQuery(query1);
												
				if(!rs.next()) {					
					map.put("success", false);
					map.put("causeRoot", "email not found");
					JSONObject json = new JSONObject(map);
					response.getWriter().println(json);
					return;
				}
				
				HttpSession session = request.getSession(true);				
				session.setAttribute("phoneNumber", phoneNumber);
				session.setAttribute("noOfPerson", noOfPerson);
				session.setAttribute("address", address);
				session.setAttribute("email", email);
				
				map.put("success", true);
				JSONObject json = new JSONObject(map);
				response.getWriter().println(json);											
				
			} catch (SQLException e1) {
				e1.printStackTrace();
			}											
		}
		
		if(type.equals("payment")) {
			String flightId = request.getParameter("flightId");
			String userId = request.getParameter("userId");
			String email = request.getParameter("email");
			String phoneNumber = request.getParameter("phoneNumber");
			String noOfPerson = request.getParameter("noOfPerson");
			String address = request.getParameter("address");
			
			String query = String.format("insert into `order`(flightId, userId, email, phoneNumber, noOfPersons, address) values('%s','%s','%s','%s','%s','%s')", 
					flightId, userId, email, phoneNumber, noOfPerson,  address);
			try {
				stmt.execute(query);
				Map<String, Object> map = new HashMap<>();
				map.put("success", true);
				JSONObject json = new JSONObject(map);
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
