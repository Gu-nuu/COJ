<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리컴공끼리</title>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="main_style.css">

</head>
<body>
	<%@ include file="navbar.jsp"%>
	
	<%
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String sql_update;
		int i=0;
		String question_img=null;
		String question_title=null;
		String question_content=null;
		int question_id=0;
		String contest_img=null;
		String contest_text=null;
		String contest_title=null;
		int contest_id=0;
		String free_text1=null;
		String free_text2=null;
		String free_text3=null;
		String free_text4=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(jdbcurl,"root","0000");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
	%>
	<script>function f(link){
		location.href=link;
	}</script>
	<div class="body-box">
		<div class="content">
			<div id="body-left-1">
				<div class="">
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">오늘의 문제</span>
						</div>
						<%
            sql_update="select * from question where id=ref order by id desc ";
            rs = stmt.executeQuery(sql_update);
            %>
            <%
                while(rs.next() && rs.getRow()<=1)
                {
                	
                	question_content=rs.getString("content");
                	question_title=rs.getString("title");
                	question_img=rs.getString("image");
                	question_id=rs.getInt("id");
                }
             %>
						<div class="noline-design" style="">
							<img class="img_css"src="question/<%= question_img%>" onerror="this.style.display='none'">
						</div>
						<div>
						<div>
						<p style="word-break:break-all;" class="b-title"><%=question_title %></p>
						</div>
							<div>
							<p style="word-break:break-all;"> 
								<%=question_content%>
							</p>
							</div>
							
						</div>
						<div class="clearfix">
							<a class="more-btn" href="question_board_post.jsp?id=<%=question_id %>" >더보기</a>
						</div>
					</div>
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">오늘의 추천 맛집</span>
						</div>
						<%
							String[] name1={"김치만 선생","필동 부대찌개","구이구이","산타 돈부리","홍탁집","알촌","동대 닭한마리","내가찜한닭","코너 스테이크","소담집","손문대구막창","짬뽕야","파파포","필동 닭칼국수","허수아비","은화수 식당","산쪼메","도스마스"};
							String[] image1={"0.jpg","1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg","12.jpg","13.jpg","14.jpg","15.jpg","16.jpg","17.jpg"};
							String[] num1={"02-6052-5526","02-2636-8735","02-2263-9292","02-2266-8151","02-2266-6332","02-2268-3434","02-2269-5596","02-2261-0299","02-6428-2204","02-2266-8450","02-2265-5167","0507-1308-2783","02-6368-8292","02-2274-7749","02-2276-1770","02-2265-1100","02-2273-0504","02-2278-7200"};
							String[] time1={"매일 10:00 - 22:00","월~토 10:00 - 21:30, 일 12:00-21:00","평일 10:30 ~ 10:30, 토요일 10:30 ~ 14:00, 일요일 휴무","평일 11:00 - 20:00, 일요일 12:00 - 20:00 (break time: 15:00 - 16:30)","매일 11:00 - 22:30, 일요일 휴무","매일 09:00 - 21:00","평일 11:00 - 23:00, 주말 11:00 - 22:00","매일 10:00 - 22:00","매일 11:15 - 20:45 (last order : 20:15)","매일 11:00 - 23:00","평일 14:00 - 24:00 (둘째주, 넷째주 일요일 휴무)","매일 10:00 - 21:00","월~금 11:00 - 20:30 (last order : 20:00), 토 11:00 - 15:00 (last order : 14:00) ,일요일 휴무","평일 10:00 - 21:00, 토요일 10:00 - 15:00","매일 07:30 - 21:30","매일 11:00 - 22:00","평일 10:30 - 21:30, 주말 11:00 - 21:00","매일 12:00 - 20:00"};
							String[] info1={"충무로의 김치찌개 맛집! 따뜻한 국물과 함께 든든하게 밥을 먹고 싶다면 강추! 계란말이와 함께 먹는다면 더더욱 맛있음!","의정부 부대찌개에도 꿀리지 않는 충무로의 대표 부대찌개 맛집! 계란 후라이가 올라간 밥과 함께 먹으면 최고!","신공학관 근처의 백반집! 신공학관에서 가깝고 많은 메뉴들 중에 하나를 고르는 재미가 있는 맛집!","충무로의 대표 돈부리 맛집! 다양한 재료들을 사용한 돈부리를 골라먹을 수 있는 재미가 있는 곳!","집밥이 그리울 때 가야하는 맛집! 싼 가격으로 든든하게 배를 채울 수 있는 백반 강추!","간단하지만 든든한 식사를 원한다면 이 곳으로! 착한 가격의 알밥으로 든든하게 배를 채우고 갈 수 있음!","동국대를 대표하는 닭한마리 맛집! 기존의 닭한마리와는 다르게 빨간 육수를 사용해서 빨닭이라는 별명을 가진 맛집!","줄여서 내찜닭이라고 불리는 충무로 찜닭 맛집! 친구들과 다같이 가서 먹으면 꿀맛! SNS 이벤트로 음료수 서비스 잊지 않기!","무려 백종원의 골목식당에도 나온 충무로 스테이크 맛집! 싼 가격에 높은 퀄리티의 스테이크를 먹고자 한다면 이곳으로!","충무로 대표 무한리필 고깃집! 착한 가격으로 고기, 밥을 양껏 먹을 수 있는 곳!","충무로의 숨겨진 고기 맛집! 대표메뉴는 갈매기살로 저렴하고 푸짐하고 서비스로 주시는 막국수와 같이 먹으면 더 꿀맛!","기존의 짬뽕과는 다른 색다른 맛을 느끼고 싶다면 바로 이곳으로! 탕수육과 함께 먹으면 더더욱 맛있음!","충무로에서 쌀국수가 먹고 싶다면 이곳으로! 착한 가격에 엄청난 양의 쌀국수를 먹을 수 있음! 물론 맛도 보장!","충무로의 대표 칼국수 맛집! 전날 술 먹고 해장이 필요하다면...? 더 말할 것도 없이 바로 이곳으로!","충무로 돈까스 맛집의 양대산맥 중 하나! 가성비 넘치는 동대생을 위한 세트메뉴 강추!","충무로 돈까스 맛집의 양대산맥 중 하나! 어마어마한 양의 돈까스부터 다양한 메뉴까지, 돈까스 러버들의 필수 방문 맛집","충무로를 대표하는 라멘 맛집! 다양한 스타일의 라멘도 맛볼 수 있고 잔맥주도 파니까 참고!","충무로 부리또 맛집이자 돈 없는 대학생들의 성지...! 과제와 프로젝트 떄문에 빠르고 간단한 식사가 필요하다면 이곳으로!"};
							String[] place1={"서울 중구 필동로 30-1","서울 중구 서애로 16-6","서울 중구 퇴계로36가길 43-5","서울 중구 서애로 19","서울 중구 퇴계로42길 8","서울 중구 서애로1길 11 해센스마트 1층 113,119호","서울 중구 서애로 16-5","서울 중구 서애로 6-1 인산빌딩","서울 중구 퇴계로 218-16","서울 중구 서애로 16-6","서울 중구 퇴계로44길 14","서울 중구 서애로 16-7 1층","서울 중구 필동로 15-7","서울 중구 필동로 15-9","서울 중구 서애로1길 20","서울 중구 서애로1길 11","서울 중구 서애로1길 26","서울 중구 필동로 33"};
					%>
						<%
							int r = (int)(Math.random()*name1.length);
						%>
						<div class="box">
							<img class="img_css" src="tasty/<%=image1[r] %>">
						</div>
							
						<div>
							<p style="word-break:break-all;" class="b-title">
							<%=name1[r] %>
							</p>
							<p style="word-break:break-all;" class="">
							<%=info1[r] %>
							</p>
						</div>
						<div class="clearfix">
							<a class="more-btn" href="tasty_board.jsp" >더보기</a>
						</div>
					</div>
				</div>
			</div>
			<div id="body-middle">
				<div class="">
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">오늘도 밤새니? 최신 글</span>
						</div>
						<%
						
						try {
							String sql = "select * from free where id=ref order by id desc limit 3";
							
							rs=stmt.executeQuery(sql);
							
						}
						catch(Exception e) {
						   out.println("DB 연동 오류입니다.:"+e.getMessage());
						}

						while(rs.next()){
							free_text1=rs.getString("title");
						%>
						<div class="box">
							<p style=" word-break:break-all; cursor:pointer;"class="b-title" onclick="f('free_board_post.jsp?id=<%=rs.getInt("id")%>')">
								<%=free_text1 %>
							</p>
						</div>
						<%} 
						%>
					</div>
					
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">스펙 UP!</span>
						</div>
						<div id="contest">
							
							<%
	
	
	try {
		String sql = "select max(ref) as max_id from contest";
		
		rs=stmt.executeQuery(sql);
		
		while(rs.next()){
			i=rs.getInt("max_id");
		}
	}
	catch(Exception e) {
	   out.println("DB 연동 오류입니다.:"+e.getMessage());
	}
	try {
		String sql = "select * from contest where id=" +i;
		
		rs=stmt.executeQuery(sql);
		
		while(rs.next()){
			contest_img=rs.getString("image");
			contest_text=rs.getString("content");
			contest_title=rs.getString("title");
		}
	}
	catch(Exception e) {
	   out.println("DB 연동 오류입니다.:"+e.getMessage());
	}
%>
							<%if(contest_img.equals("null")){ %>
			
							<div style="width:100%">
								<p style="word-break:break-all;" class="b-title">
									<%=contest_title %>
								</p>
								<p style="word-break:break-all;">
									<%=contest_text %>
								</p>
							</div>
							<%}else{ %>
							<div class="noline-design" style="width:50%;">
								<img src="contest/<%=contest_img%>" class="img_css" onerror="this.style.display='none'">
							</div>
							<div style="width:50%">
								<p style="word-break:break-all;" class="b-title">
									<%=contest_title %>
								</p>
								<p style="word-break:break-all;">
									<%=contest_text %>
								</p>
							</div>
							<%}%>
						</div>
						
						<div class="clearfix">
							<a class="more-btn" href="contest_board.jsp" >더보기</a>
						</div>
					</div>
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">학사공지</span>
						</div>
						<div class="notice">
							<%@ include file="notice_crawling.jsp" %>
						</div>
						<div class="clearfix">
							<a class="more-btn" href="<%=url %>" >더보기</a>
						</div>
					</div>
				</div>
			</div>
			<div id="body-right-1">
				<div class="">
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">명예의 전당</span>
						</div>
						<div class="fancy-design">
						<div class="inner-content-main noline-design">
                            <div class="first">
                                
                                <%
                                String most_heart = null;
                                String most_reply = null;
                                String most_post = null;
                                String its_name=null;
                                String[] sql_f = {"reply", "heart"};
                                String[] sql_f2 = {"댓글", "좋아요"};
                                
                                String[] type_f ={"free", "contest", "question"};
                                String[] type_f2 ={"자유", "공모전", "예제문제"};
                                
		                        int rand_s =(int)(Math.random()*2);
                                int rand_t = (int)(Math.random()*3);
                                	 rs = stmt.executeQuery("select * from "+type_f[rand_t]+" order by "+sql_f[rand_s]+" desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_reply = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_reply+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");	
									}
		                        %>
		                        <div class="inner-title">
		                        		<p>[ <%=type_f2[rand_t] %>게시판 ]</p>
                            			<p>🏆이달의 <%= sql_f2[rand_s]%>왕🏆</p>
                        		</div>	
                        		<div class="user-emo noline-design">
                                
                                    <h1>👑</h1>
                                </div>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_reply %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
						</div>
						<div class="clearfix">
							<a class="more-btn" href="fame_hall.jsp" >더보기</a>
						</div>
					</div>
					<div class="box">
						<div class="menu-name">
							<span class="font-default font-bold">퀵 메뉴</span>
						</div>
						<div class="quick-menu-box">
							<a href="http://www.dongguk.edu">
								<img class="quick-icon" src="img/dongguk-page.png">
								<span class="quick-font">동국대학교 홈페이지</span>
							</a>
						</div>
						<div class="quick-menu-box">
							<a href="https://eclass.dongguk.edu/">
								<img class="quick-icon" src="img/eclass.png">
								<span class="quick-font">이클래스</span>
							</a>
						</div>
						<div class="quick-menu-box">
							<a href="http://cse.dongguk.edu/">
								<img class="quick-icon" src="img/computer-page.png">
								<span class="quick-font">컴퓨터공학전공 홈페이지</span>
							</a>
						</div>
						<div class="quick-menu-box">
							<a href="https://mail.dongguk.edu/">
								<img class="quick-icon" src="img/webmail.png">
								<span class="quick-font">동국대학교 웹메일</span>
							</a>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<%@ include file="footer.jsp" %>
	</div>
	
</body>
</html>