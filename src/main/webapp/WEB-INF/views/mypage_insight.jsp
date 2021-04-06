<%@page import="java.io.PrintWriter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Collections"%>
<%@page import="com.exam.MyPage.WeekTO"%>
<%@page import="com.exam.MyPage.TodayTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String changeRow = (String)request.getAttribute("changeRow");
    
	 // TodayCounts, weekcount ArrayList로 받아오기
	 	ArrayList<TodayTO> today_counts = (ArrayList)request.getAttribute("today_count");
	 	ArrayList<WeekTO> week_counts = (ArrayList)request.getAttribute("week_count");

	 	if(today_counts.size()!= 0 && week_counts.size()!= 0){
		 	if(today_counts.get(0).getTime() == 0){
		 		today_counts.remove(0);
		 	}
		 	if(week_counts.get(0).getTime() == 0){
		 		week_counts.remove(0);
		 	}
	 	}
	 	
	 	ArrayList<TodayTO> blank_count_today = new ArrayList();
	 	for (int i = 1; i<=8; i++){
	 		TodayTO to = new TodayTO();
	 		to.setAction_count(0);
	 		to.setComment_count(0);
	 		to.setHit_count(0);
	 		if(i==7 || i ==8){
	 			to.setTime(3*i);
	 			blank_count_today.add(to);
	 		} else {
	 			to.setTime((3*i) -1); 
	 			blank_count_today.add(to);
	 		}
	 	}
	 	
	 	for (int i = 0; i<=7; i++){
	 		//System.out.println(blank_count_today.get(0).getTime()+" : " +blank_count_today.get(1).getTime()+" : " +blank_count_today.get(2).getTime()+" : " +blank_count_today.get(3).getTime()+" : " +blank_count_today.get(4).getTime()+" : " +blank_count_today.get(5).getTime()+" : " +blank_count_today.get(6).getTime());
	 		for(TodayTO to : today_counts){
	 			if(i == 6 || i==7){
	 				if(to.getTime() == (3*i +3)){
	 					blank_count_today.remove(i);
	 					blank_count_today.add(i,to);
	 					//System.out.println("index :"+i+"|| to.getTime() :"+ (3*i +3));
	 					break;
	 				}
	 			}else {
	 				if(to.getTime()== (3*i+2)){
	 					blank_count_today.remove(i);
	 					blank_count_today.add(i,to);
	 					//System.out.println("index :"+i+"|| to.getTime() :"+ ((3*i)+2));
	 					break;
	 				}
	 			}
	 		}
	 	}
	 	
	 	// 순서 바꿈
	 	Collections.reverse(blank_count_today);
	 	
	 	ArrayList<Integer> today_action = new ArrayList();
	 	ArrayList<Integer> today_hit = new ArrayList();
	 	ArrayList<Integer> today_comment = new ArrayList();
	 	ArrayList<Integer> today_like = new ArrayList();
	 	ArrayList<String> today_time = new ArrayList();
	 	
	 	for(TodayTO to : blank_count_today){
	 		today_hit.add(to.getHit_count());
	 		today_like.add(to.getLike_count());
	 		today_comment.add(to.getComment_count());
	 		today_time.add("\""+to.getTime() + "시간 전("+(LocalDateTime.now().minusHours(to.getTime())).toString().substring(11,16)+")\"");
	 		today_action.add(to.getHit_count() + to.getComment_count() + to.getLike_count());
	 	}
	 			
	 		
	 	
	 	
	 	// 출력 될 list 생성
	 	ArrayList<Integer> week_action = new ArrayList();
	 	ArrayList<Integer> week_hit = new ArrayList();
	 	ArrayList<Integer> week_comment = new ArrayList();
	 	ArrayList<Integer> week_like = new ArrayList();
	 	ArrayList<String> week_time = new ArrayList();
	 	// 기존 Arraylist 만들고
	 	ArrayList<WeekTO> blank_count_week = new ArrayList();
	 	for(int i=1; i<=7;i++){
	 		WeekTO to1 = new WeekTO();
	 		to1.setComment_count(0);
	 		to1.setHit_count(0);
	 		to1.setLike_count(0);
	 		to1.setTime(i);
	 		blank_count_week.add(to1);
	 	}
	 	// 받아온 데이터 교체해주기
	 	for (int i =0; i<7; i++){
	 			for(WeekTO to : week_counts){
	 				if(to.getTime()==i+1){
	 					blank_count_week.remove(i);
	 					blank_count_week.add(i,to);
	 					//System.out.println(to.getHit_count() + "시작" + i);
	 					break;
	 				}
	 			}		
	 	}
	 	// 순서 바꿈
	 	Collections.reverse(blank_count_week);
	 	// 각각의 Arraylist에 입력
	 	for (WeekTO to1 : blank_count_week){
	 		week_hit.add(to1.getHit_count());
	 		week_comment.add(to1.getComment_count());
	 		week_like.add(to1.getLike_count());
	 		week_action.add(to1.getHit_count()+ to1.getComment_count()+to1.getLike_count());
	 		week_time.add("\""+Integer.toString(to1.getTime())+ "일 전 ("+(LocalDateTime.now().minusDays(to1.getTime())).toString().substring(5,10)+")\"" );
	 	}
    %>
<!-- high charts -->
<div>
				<div style="padding-left:5%; margin-bottom:20px; margin-top:20px;">
					<h2>게시글 인사이트</h2>
				</div>
				<hr>
				<div>
					<div style="float: left; width: 50%; padding-left:5%">
						<div class="btn-group" style="padding-left:10%;" >
						  <button type="button" class="btn btn-outline-secondary catalogue1" value="action">액션</button>
						  <button type="button" class="btn btn-outline-secondary catalogue1" value="hit">조회수</button>
						  <button type="button" class="btn btn-outline-secondary catalogue1" value="like">좋아요</button>
						  <button type="button" class="btn btn-outline-secondary catalogue1" value="comment">댓글</button>
						</div>
					</div>
					<div style="float: left; width: 50%; padding-left:25%">
							<select class="form-select btn-outline-secondary" style="width: 200px;" aria-label="Default select example">
								<option value="day">일주일 조회</option>
								<option value="time">하루 조회(24시간)</option>
							</select>
					</div>
				</div>
				<div style="padding-left:10%; padding-top:3%">
					<h6 style="color:gray; font-size:10px;">액션은 '조회수','좋아요','댓글'를 합친 횟수입니다.</h6>
				</div>
		    	<div align="center">
		    		<div id="container2" style="width: 1000px; height: 500px; margin: 0 auto;" align="center";></div>
		    	</div>
	    	</div>
	    	<br><hr><br>
<script>
	let catalogue1 = "action";
	let timecontrol1 = "day";
	var title1 = {text: "액션 별 모아보기"};
	var xAxis1 = {categories: <%=week_time%>};
	var series1 =  [
	    {
	       name: 'action',
	       data: <%=week_action%>
	    }
 	];

// 하이차트 실행 함수
function highChartFunc1() {
   var subtitle1 = {
        text: 'by BOOKMARK'
   };
   var yAxis1 = {
      title: {
         text: '발생 횟 수'
      },
      plotLines: [{
         value: 0,
         width: 1,
         color: '#808080'
      }]
   };   
   var tooltip1 = {
      valueSuffix: '회'
   }
   var legend1 = {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0
   };
   var json1 = {};

   if(timecontrol1== "time"){
	   xAxis1 = {categories: <%=today_time%>};
		if(catalogue1 == "action"){
			title1 = {text: "액션 별 모아보기"};
			series1 =  [
			    {
			       name: '"액션" for 24h',
			       data: <%=today_action%>
			    }
		    ];
		} else if (catalogue1 == "hit"){
			title1 = {text: "조회수 별 모아보기"};
			series1 =  [
			    {
			       name: '"조회수" for 24h',
			       data: <%=today_hit%>
			    }
		    ];
		} else if (catalogue1 == "like"){
			title1 = {text: "좋아요 별 모아보기"};
			series1 =  [
			    {
			       name: '"좋아요" for 24h',
			       data: <%=today_like%>
			    }
		    ];
		} else if(catalogue1 == "comment"){
			title1 = {text: "댓글 별 모아보기"};
			series1 =  [
			    {
			       name: '"댓글" for 24h',
			       data: <%=today_comment%>
			    }
		    ];
		}
	} else {
		xAxis1 = {categories: <%=week_time%>};
		if(catalogue1 == "action"){
			title1 = {text: "액션 별 모아보기"};
			series1 =  [
			    {
			       name: '"액션" for a week',
			       data: <%=week_action%>
			    }
		    ];
		} else if (catalogue1 == "hit"){
			title1 = {text: "조회수 별 모아보기"};
			series1 =  [
			    {
			       name: '"조회수" for a week',
			       data: <%=week_hit%>
			    }
		    ];
		} else if (catalogue1 == "like"){
			title1 = {text: "좋아요 별 모아보기"};
			series1 =  [
			    {
			       name: '"좋아요" for a week',
			       data: <%=week_like%>
			    }
		    ];
		} else if(catalogue1 == "comment"){
			title1 = {text: "댓글 별 모아보기"};
			series1 =  [
			    {
			       name: '"댓글" for a week',
			       data: <%=week_comment%>
			    }
		    ];
		}
	}
   	
   json1.title = title1;
   json1.subtitle = subtitle1;
   json1.xAxis = xAxis1;
   json1.yAxis = yAxis1;
   json1.tooltip = tooltip1;
   json1.legend = legend1;
   json1.series = series1;
   
   $('#container2').highcharts(json1);
   //console.log("함수 실행");
}
  	
// 마이페지이 로드 시, 차트 로딩
$(document).ready(function() {
	highChartFunc1();
});

//액션,조회수,좋아요,댓글 클릭 시
$(function() {
	$(document).on("click",".catalogue1",function(){
		catalogue1 = $(this).attr("value");
		highChartFunc1();
	});
});
// 시간 구분 클릭 시, default 
$(function() {
	$(document).on("change",".form-select",function(){
        timecontrol =$(this).val();
		highChartFunc1();
	});
});
			
//myModal.dispose()
</script>