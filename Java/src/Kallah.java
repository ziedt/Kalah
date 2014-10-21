import java.awt.* ; 
import java.awt.event.* ; 
import java.io.* ; 
import java.net.* ;

import javax.swing.* ; 
import javax.swing.border.* ; 

public class Kallah extends JFrame implements ActionListener {
	
   JButton mHouse10, mHouse11, mHouse12,
   			mHouse13, mHouse14, mHouse15,
	   		mHouse20, mHouse21, mHouse22,
	   		mHouse23, mHouse24, mHouse25,
	   		mValidateBt;
   JLabel mPlayer1, mPlayer2;
   JTextField mCommandTF; 
   
   BufferedReader br ; 
   BufferedWriter bw ;
   Thread inputStreamThread ; 
   Process prologProcess ; 
   String prolog ; 
   String mPrologFile ; 
   String mFirstPlayer ; 
   String mSecondPlayer ; 
   
   boolean mShouldPlayer1Play = false;
   boolean mShouldPlayer2Play = false;
   boolean mShouldConfirm = false;

   public Kallah(String prolog, String prologFile, String firstPlayer, String secondPlayer) { 
      this.prolog = prolog ; 
      this.mPrologFile = prologFile ;
      mFirstPlayer = firstPlayer;
      mSecondPlayer = secondPlayer;
      
      generateUI();

      Connector connector = new Connector(54321) ; 
      connector.start(); 
      
      Socket sock ;
      try {
         sock = new Socket("127.0.0.1",54321) ;
         br = new BufferedReader(new InputStreamReader(sock.getInputStream())) ; 
         bw = new BufferedWriter(new OutputStreamWriter(sock.getOutputStream())) ; 
      } catch(Exception x) { System.out.println(x) ; }

      inputStreamThread = new Thread() {
         public void run() { 
            while(true) {
               try{
                  String s = br.readLine() ;
                  decode(s);
               } catch(Exception xx) { System.out.println(xx) ; }
            }  
         }
      } ;
      inputStreamThread.start() ;

      Thread shows = new Thread() { 
         public void run() { 
            setVisible(true) ;
         }
      } ;
      EventQueue.invokeLater(shows);

      // Start the prolog player

      try { 
         prologProcess = 
           Runtime.getRuntime().exec(prolog + " -f " + mPrologFile) ; 
      } catch(Exception xx) {System.out.println(xx) ; }

      // On closing, kill the prolog process first and then exit
      this.addWindowListener(new WindowAdapter() { 
         public void windowClosing(WindowEvent w) { 
            if (prologProcess != null) prologProcess.destroy() ;
            System.exit(0) ; 
         }
      }) ; 

   } 

   protected void decode(String s) {
	   System.out.println("Kallah.decode()");
	   System.out.println("\t"+s);
	   if(s.equals("tempo")){
		   mShouldConfirm = true;
			  mValidateBt.setText("Validate");
		   mValidateBt.setBackground(Color.GREEN);
		   return;
	   } else if(s.equals("start")){
           writeProlog("("+mFirstPlayer+","+mSecondPlayer+").");
   		}
	   String[] tab = s.split(";");
	   if(tab.length == 0){
		   return;
	   }
	   if(tab[0].equals("human")){
		   int playerId = Integer.parseInt(tab[1]);
		   if(playerId == 1){
			   mShouldPlayer1Play = true;
				  mValidateBt.setBackground(Color.MAGENTA);
				  mValidateBt.setText("Player 1 Turn");
		   } else {
			   mShouldPlayer2Play = true;
				  mValidateBt.setBackground(Color.CYAN);
				  mValidateBt.setText("Player 2 Turn");

		   }
	   } else if(tab[0].equals("tab")){
		   int playerId = Integer.parseInt(tab[1]);
		   System.out.println("PlayerId="+playerId);
		   System.out.println("SelectedHole="+tab[2]);
		   if(playerId == 1){
			  mHouse10.setText(tab[3]);
			  mHouse11.setText(tab[4]);
			  mHouse12.setText(tab[5]);
			  mHouse13.setText(tab[6]);
			  mHouse14.setText(tab[7]);
			  mHouse15.setText(tab[8]);

			  mHouse20.setText(tab[9]);
			  mHouse21.setText(tab[10]);
			  mHouse22.setText(tab[11]);
			  mHouse23.setText(tab[12]);
			  mHouse24.setText(tab[13]);
			  mHouse25.setText(tab[14]);
		   } else {
			  mHouse10.setText(tab[9]);
			  mHouse11.setText(tab[10]);
			  mHouse12.setText(tab[11]);
			  mHouse13.setText(tab[12]);
			  mHouse14.setText(tab[13]);
			  mHouse15.setText(tab[14]);

			  mHouse20.setText(tab[3]);
			  mHouse21.setText(tab[4]);
			  mHouse22.setText(tab[5]);
			  mHouse23.setText(tab[6]);
			  mHouse24.setText(tab[7]);
			  mHouse25.setText(tab[8]);
		   }
		   
	   }
   }
	
   private void generateUI() {
	   mHouse10 = new JButton("4");
	   mHouse11 = new JButton("4");
	   mHouse12 = new JButton("4");
	  mHouse13 = new JButton("4");
	  mHouse14 = new JButton("4");
	  mHouse15 = new JButton("0");
	  mHouse10.setBackground(Color.MAGENTA);
	  mHouse11.setBackground(Color.MAGENTA);
	  mHouse12.setBackground(Color.MAGENTA);
	  mHouse13.setBackground(Color.MAGENTA);
	  mHouse14.setBackground(Color.MAGENTA);
	  mHouse15.setBackground(Color.MAGENTA);
	  mHouse10.addActionListener(this);
	  mHouse11.addActionListener(this);
	  mHouse12.addActionListener(this);
	  mHouse13.addActionListener(this);
	  mHouse14.addActionListener(this);
	  mHouse10.setActionCommand("0.");
	  mHouse11.setActionCommand("1.");
	  mHouse12.setActionCommand("2.");
	  mHouse13.setActionCommand("3.");
	  mHouse14.setActionCommand("4.");
	  mHouse20 = new JButton("4");
	  mHouse21 = new JButton("4");
	  mHouse22 = new JButton("4");
	  mHouse23 = new JButton("4");
	  mHouse24 = new JButton("4");
	  mHouse25 = new JButton("0");
	  mHouse20.setBackground(Color.CYAN);
	  mHouse21.setBackground(Color.CYAN);
	  mHouse22.setBackground(Color.CYAN);
	  mHouse23.setBackground(Color.CYAN);
	  mHouse24.setBackground(Color.CYAN);
	  mHouse25.setBackground(Color.CYAN);
	  mHouse20.addActionListener(this);
	  mHouse21.addActionListener(this);
	  mHouse22.addActionListener(this);
	  mHouse23.addActionListener(this);
	  mHouse24.addActionListener(this);
	  mHouse20.setActionCommand("0.");
	  mHouse21.setActionCommand("1.");
	  mHouse22.setActionCommand("2.");
	  mHouse23.setActionCommand("3.");
	  mHouse24.setActionCommand("4.");
	
	  mPlayer1 = new JLabel("Player 1");
	  mPlayer2 = new JLabel("Player 2");
	  mPlayer1.setForeground(Color.MAGENTA);
	  mPlayer2.setForeground(Color.CYAN);
	
	  mValidateBt = new JButton("Validate") ;
	  mCommandTF = new JTextField();
	  mValidateBt.addActionListener(this) ; 
	  JPanel panel = new JPanel() ; 
	  panel.setLayout(new GridLayout(4,7)) ;
	  for(int i=0;i<7;i++){
		  if(i==3){
			  panel.add(new JLabel("Kallah"));
	  } else if(i==4){
		  panel.add(mValidateBt);
	  } else {
		  panel.add(new JLabel(""));
		  }
	  }
	  panel.add(mPlayer1);
	  panel.add(mHouse14);
	  panel.add(mHouse13);
	  panel.add(mHouse12);
	  panel.add(mHouse11);
	  panel.add(mHouse10);
	  panel.add(new JLabel("<=="));
	  panel.add(mHouse15);
	  for(int i=0;i<5;i++){
		  panel.add(new JLabel(""));  
	  }
	  panel.add(mHouse25);
	  panel.add(new JLabel("==>"));
	  panel.add(mHouse20);
	  panel.add(mHouse21);
	  panel.add(mHouse22);
	  panel.add(mHouse23);
	  panel.add(mHouse24);
	  panel.add(mPlayer2);
	
	  this.setTitle("Kallah") ; 
	  Border panelborder = BorderFactory.createLoweredBevelBorder() ; 
	  panel.setBorder(panelborder) ; 
	  this.getContentPane().add(panel) ; 
	  this.setSize(900,300) ;
	  this.setLocation(300,300) ;	
   }

public static void main(String[] args) { 
      String prolog = "swipl" ; //Environment Variable
      String mFile = "D:\\Programmation\\git_github\\Projet-Prolog\\auto_launch_java.pl";
      String firstPlayer = "java_player";
      String secondPlayer = "java_player";
      boolean noargs = true ; 
      try { 
         prolog = args[0] ;
         mFile = args[1] ;
         noargs = false ; 
      } 
      catch (Exception xx) {
         System.out.println("usage: java Kallah  <where prolog>  <where auto_launch_java.pl>") ; 
      }
      if (noargs) { 
         Object[] message = new Object[4] ; 
         message[0] = new Label("Prolog Commande") ;
         message[1] = new JTextField(prolog) ; 
         message[2] = new Label("auto_launch_java.pl Location") ;
         message[3] = new JTextField(mFile) ; 
         try { 
            int I = JOptionPane.showConfirmDialog(null,message,"Where are Prolog and auto_launch_java.pl ? ",JOptionPane.OK_CANCEL_OPTION) ;  
            if (I == 2 | I == 1) System.exit(0) ;
            System.out.println(I) ;
            prolog = ((JTextField)message[1]).getText().trim();
            mFile = ((JTextField)message[3]).getText().trim();
         } catch(Exception yy) {} 
      }

      File file= new File(mFile);
      if(!file.exists()){
    	  System.out.println("Wrong pl Location.");
    	  System.exit(1);
      }
      
      String[] possibilities = {"java_player","random_player","greedy_strategy","most_seed_player","minimax_def_player","minimax","end_in_store"};
      Object[] message = new Object[4] ; 
      message[0] = new Label(" First Player ") ;
      message[1] = new JComboBox(possibilities);
      message[2] = new Label(" Second Player ") ;
      message[3] = new JComboBox(possibilities);; 
      try { 
          int I = JOptionPane.showConfirmDialog(null,message,"Please Choose your Player",JOptionPane.OK_CANCEL_OPTION) ;  
          if (I == 2 | I == 1) System.exit(0) ;
          System.out.println(I) ;
          firstPlayer = (String)((JComboBox)message[1]).getSelectedItem();
          secondPlayer = (String)((JComboBox)message[3]).getSelectedItem();
       } catch(Exception yy) {} 

      
      new Kallah(prolog,mFile, firstPlayer, secondPlayer) ; 
   }



   /**
     * Java player
     */
   public void actionPerformed(ActionEvent act) {
	  JButton source = (JButton)act.getSource();
	  if(mShouldPlayer1Play && 
			  (source == mHouse10 || source == mHouse11 || source == mHouse12 || 
			  source == mHouse13 || source == mHouse14)){
		  mShouldPlayer1Play = false;
		  mValidateBt.setBackground(Color.LIGHT_GRAY);
		  mValidateBt.setText("Waiting ...");
		  String cmd = source.getActionCommand(); 
		  writeProlog(cmd);
	  }else if(mShouldPlayer2Play && 
		  (source == mHouse20 || source == mHouse21 || source == mHouse22 || 
		  source == mHouse23 || source == mHouse24)){
		  mShouldPlayer2Play = false;
		  mValidateBt.setBackground(Color.LIGHT_GRAY);
		  mValidateBt.setText("Waiting ...");
		  String cmd = source.getActionCommand(); 
		  writeProlog(cmd);		  
	  } else if(source == mValidateBt && mShouldConfirm){
		  mShouldConfirm = false;
		  writeProlog("0.");
		  mValidateBt.setText("Waiting ...");
		  mValidateBt.setBackground(Color.LIGHT_GRAY);
	  }
   }
   
   public void writeProlog(String cmd){
	   System.out.println("Kallah.writeProlog()");
	   System.out.println("\t"+cmd);
      try { 
          bw.write(cmd + "\n") ; 
          bw.flush() ;  
      } catch(Exception xx) { System.out.println(xx) ; } 
   }

}
