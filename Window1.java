import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.stage.Stage;
import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

public class Window1 extends Application implements EventHandler<ActionEvent> {
	public static String priority="0";
	public static String TransferVaulue1="0";
	public static String TransferVaulue2="0";
	public static String Sport="Football";
	public static ComboBox sportComboBox = new ComboBox();
	public static ComboBox priorityComboBox = new ComboBox();
	public static ComboBox TVComboBox = new ComboBox();
	TextField   textField = new TextField ("Answer");
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		launch(args);
	}

	@Override
	public void start(Stage stage) throws Exception {
		// TODO Auto-generated method stub
		Image image = new Image("barca.png");
		ImageView mv=new ImageView(image);
		
		Group root=new Group();
		root.getChildren().add(mv);
		
        priorityComboBox.getItems().addAll(
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10"
            
        );
        TVComboBox.setPromptText("in Million $");
        TVComboBox.getItems().addAll(
            "0-51",
            "51-100",
            "101-150",
            "151-200",
            "201-250",
            "251-300",
            "301-350"
        );   
       
        sportComboBox.getItems().addAll(
            "Football",
            "Basketball",
            "Ice Hockey",
            "Futsal"
        );   
        TVComboBox.setValue("Choose Transfer value");
        priorityComboBox.setValue("Choose priority");
        sportComboBox.setValue("Choose Sport");
        TVComboBox.setTranslateX(500);
        TVComboBox.setTranslateY(220);
        priorityComboBox.setTranslateX(515);
        priorityComboBox.setTranslateY(10);
        sportComboBox.setTranslateX(520);
        sportComboBox.setTranslateY(60);
        textField.setTranslateX(10);
        textField.setTranslateY(70);
        
        Button b = new Button("Enter");
        b.setTranslateX(560);
        b.setTranslateY(250);
        b.setOnAction(this);
        GridPane grid = new GridPane();
        
        grid.add(priorityComboBox, 100,11 );
        grid.add(TVComboBox, 100, 15);
        grid.add(sportComboBox,100, 20);
        grid.add(b, 100, 120);
        grid.add(textField,100,150);
        


        root.getChildren().add(grid);
        Scene scene=new Scene(root,700,400);
		stage.setScene(scene);
		stage.setResizable(false);
		stage.show();
	}
	@Override
	public void handle(ActionEvent event) {
		Sport=(String)sportComboBox.getValue();
		priority=(String)priorityComboBox.getValue();
		String temp=(String)TVComboBox.getValue();
		//System.out.println(temp);
		TransferVaulue1=temp.split("-")[0] + "000000";
		TransferVaulue2=temp.split("-")[1] + "000000";
		System.out.println(priority);
		System.out.println(TransferVaulue1);
		System.out.println(TransferVaulue2);
		System.out.println(Sport);
		textField.setText(Main.Query(priority, TransferVaulue1,TransferVaulue2, Sport));
		
	}

}
