import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
public class Window2 extends Application implements EventHandler<ActionEvent>{
	 public static ComboBox TeamComboBox = new ComboBox();
	 public String Team="";
	 public static TextField textField = new TextField ();

public void start(Stage stage) {
		
		//Code to add background image
		Image image = new Image("barca.png");

		ImageView mv=new ImageView(image);
		
		Group root=new Group();
		root.getChildren().addAll(mv);
		
	
	        TeamComboBox.getItems().addAll(
	            "FC Barcelona",
	            "FC Barcelona Femini",
	            "FC Barcelona Ice Hockey",
	            "FC Barcelona Basquet",
	            "FC Barcelona Futsal"
	            
	        );
	        TeamComboBox.setTranslateX(250);
	        TeamComboBox.setTranslateY(130);
	        textField.setTranslateX(250);
	        textField.setTranslateY(105);
	        TeamComboBox.setValue("Choose Team");
	        
	        
	        Button b = new Button("Enter");
	        b.setTranslateX(320);
	        b.setTranslateY(200);
	        b.setOnAction(this);
	        GridPane grid = new GridPane();

	        grid.add(TeamComboBox, 100,11 );
	        
	        grid.add(b, 100, 120);
	        grid.add(textField,100,150);
	        


	        root.getChildren().add(grid);

		Scene scene=new Scene(root,700,400);
		stage.setScene(scene);
		stage.setResizable(false);
		stage.show();

	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		launch(args);
	}
	@Override
	public void handle(ActionEvent event) {
		Team=(String)TeamComboBox.getValue();
		
		textField.setText(Main.Query(Team));
		
	}

}
