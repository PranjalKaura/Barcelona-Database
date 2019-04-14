import java.sql.*;


public class Main {

	public static String Query(String priority,String transferValue1,String transferValue2,String Sport) {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conObject=DriverManager.getConnection("jdbc:mysql://localhost:3306/Barcelona?useSSL=false", "root", "pranjal2@");
			Statement stmt=conObject.createStatement();
			String Query="Select Players.name from Players join Teams on Team_Name=Teams.Name join Transfer_data on transfer_data.player_ID=players.ID where Club_Priority>="+priority + " and transfer_Money>=" + transferValue1+ " and   transfer_Money<=" + transferValue2 + " and sport=\"" + Sport + "\"";
			ResultSet result=stmt.executeQuery(Query);
//			while(result.next()) {
//				int counter=1;
//				while(true) {
//					try {
//						System.out.print(result.getString(counter) +  " ");
//						counter++;
//					}
//					catch(Exception e) {
//						System.out.println();
//						break;
//					}
//				}
//			
//			}
			if(result.next())
			return result.getString(1);
			else {
				return "Empty Set";
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	public static String Query(String Team) {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conObject=DriverManager.getConnection("jdbc:mysql://localhost:3306/Barcelona?useSSL=false", "root", "pranjal2@");
			Statement stmt=conObject.createStatement();
			String Query="Select admin.name from teams join admin on teams.president_ID=admin.ID where teams.name=\""  + Team + "\"";
			System.out.println(Query);
			ResultSet result=stmt.executeQuery(Query);
			if(result.next())
			return result.getString(1);
			else {
				return "Empty Set";
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}

}
