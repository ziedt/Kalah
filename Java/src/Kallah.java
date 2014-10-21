import java.awt.* ; 
import java.awt.event.* ; 
import java.awt.image.BufferedImage;
import java.io.* ; 
import java.net.* ;

import javax.imageio.ImageIO;
import javax.swing.* ; 
import javax.swing.border.* ; 

public class Kallah extends JFrame implements ActionListener, MouseListener {

        final static int WIDTH = 70;
        final static int HEIGHT = 70;
        ImagePanel mPanel; 
        JButton mValidateBt;
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
                        	
                        	mPanel.setValue(tab[3], tab[4], tab[5], tab[6], tab[7], tab[8], tab[9], tab[10], tab[11], tab[12], tab[13], tab[14]);
                                
                        } else {
                        	mPanel.setValue(tab[9], tab[10], tab[11], tab[12], tab[13], tab[14], tab[3], tab[4], tab[5], tab[6], tab[7], tab[8]);
                        }

                }
        }

        private void generateUI() {
                mValidateBt = new JButton("Validate") ;
                mCommandTF = new JTextField();
                mValidateBt.addActionListener(this) ; 
                
                mPanel = new ImagePanel();
                mPanel.addMouseListener(this);
                mPanel.setValue(""+4, ""+4, ""+4, ""+4, ""+4, ""+0, ""+4, ""+4, ""+4, ""+4, ""+4, ""+0);
                this.setTitle("Kallah") ; 
                
                this.add(mPanel) ; 
                this.setSize(806,594) ;
                this.setResizable(false);
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
                if(source == mValidateBt && mShouldConfirm){
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

        @Override
        public void mouseClicked(MouseEvent e) {
                int num = -1;
                if(e.getX() > 203 && e.getX() < 270){
                        num = 4;
                } else if(e.getX() > 285 && e.getX() < 351){
                        num = 3;
                } else if(e.getX() > 367 && e.getX() < 434){
                        num = 2;
                } else if(e.getX() > 446 && e.getX() < 513){
                        num = 1;
                } else if(e.getX() > 527 && e.getX() < 596){
                        num = 0;
                }  
                if(mShouldPlayer1Play && e.getY() > 209 && e.getY() < 275 && num != -1){
                        mShouldPlayer1Play = false;
                        mValidateBt.setBackground(Color.LIGHT_GRAY);
                        mValidateBt.setText("Waiting ...");
                        String cmd = num+"."; 
                        writeProlog(cmd);
                }else if(mShouldPlayer2Play && e.getY() > 292 && e.getY() < 358 && num != -1){
                        mShouldPlayer2Play = false;
                        mValidateBt.setBackground(Color.LIGHT_GRAY);
                        mValidateBt.setText("Waiting ...");
                        num = 4-num;
                        String cmd = num+"."; 
                        writeProlog(cmd);                  
                }
        }

        @Override
        public void mouseEntered(MouseEvent e) {
        }

        @Override
        public void mouseExited(MouseEvent e) {
        }

        @Override
        public void mousePressed(MouseEvent e) {
        }

        @Override
        public void mouseReleased(MouseEvent e) {        
        }

        
        private class ImagePanel extends JPanel{

        	String h00, h01, h02, h03, h04, h05,
        	h10, h11, h12, h13, h14, h15;
        	            
        	public void setValue(String h00,String h01,String h02,String h03,String h04, String h05,
        			String h10,String h11,String h12,String h13,String h14, String h15){
        		this.h00 = h00;
        		this.h01 = h01;
        		this.h02 = h02;
        		this.h03 = h03;
        		this.h04 = h04;
        		this.h05 = h05;
        		this.h10 = h10;
        		this.h11 = h11;
        		this.h12 = h12;
        		this.h13 = h13;
        		this.h14 = h14;
        		this.h15 = h15;
        		repaint();
        	}
        	
			@Override
			protected void paintComponent(Graphics g) {
				super.paintComponent(g);
				try {
					BufferedImage img;
					img = ImageIO.read(new File("fond.png"));
					g.drawImage(img, 0, 0, 800, 566, null);
				} catch (IOException e) {
					e.printStackTrace();
				}
				g.setColor(Color.WHITE);
				g.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 30));
				g.drawString(""+h00, 550, 250);
				g.drawString(""+h01, 467, 250);
				g.drawString(""+h02, 389, 250);
				g.drawString(""+h03, 307, 250);
				g.drawString(""+h04, 227, 250);
				g.drawString(""+h05, 127, 290);
				g.drawString(""+h10, 227, 330);
				g.drawString(""+h11, 307, 330);
				g.drawString(""+h12, 389, 330);
				g.drawString(""+h13, 467, 330);
				g.drawString(""+h14, 550, 330);
				g.drawString(""+h15, 650, 290);
			}
        	
        }
}
