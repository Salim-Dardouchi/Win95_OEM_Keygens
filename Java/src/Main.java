import java.util.Random;
import java.util.Arrays;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.Toolkit;
import javax.swing.*;

public class Main{
    private static String m_strKey = "";
    private static JLabel m_labKey = new JLabel("Key: " + m_strKey);
    private static JFrame m_frame = new JFrame("Java Win95 Keygen");

    public static void main(String[] args){
        m_frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        JButton btnGen = new JButton("Generate Key");
        btnGen.addActionListener(e->GenerateOemKey());
        
        JButton btnCpy = new JButton("Copy to clipboard");
        btnCpy.addActionListener(e->CopyToClipboard());

        Box vb = Box.createVerticalBox();
        Box hb = Box.createHorizontalBox();

        vb.add(m_labKey);
        vb.add(new JSeparator());
        vb.add(hb);
        vb.setAlignmentX(Box.CENTER_ALIGNMENT);
        vb.setAlignmentY(Box.CENTER_ALIGNMENT);

        hb.add(btnGen);
        hb.add(btnCpy);

        m_frame.add(vb);
        m_frame.setSize(360, 120);

        m_frame.setVisible(true);
    }

    public static void GenerateOemKey(){
        Random rng = new Random();
        int iDay = rng.nextInt(0, 366);
        int iYear = (95+(rng.nextInt(0, 7)))%100;
        int iUnchk = rng.nextInt(0, 99999);

        int[] iMod7Table = new int[5];
        int iCount = 0;
        
        do{
            iCount = 0;
            Arrays.fill(iMod7Table, 0);
            
            for(int i=0; i<5; i++){
                iMod7Table[i] = rng.nextInt(0, 10);
                iCount+=iMod7Table[i];
            }    
        }while((iCount%7!=0));
        
        int iMod7 = 0;
        for(int i=0; i<5; i++){
            iMod7*=10;
            iMod7+=iMod7Table[i];
        }

        m_strKey = String.format("%03d%02d-OEM-00%05d-%05d", iDay, iYear, iMod7, iUnchk);
        m_labKey.setText("Key: " + m_strKey);
        m_labKey.setAlignmentX(JLabel.CENTER_ALIGNMENT);
    }

    public static void CopyToClipboard(){
        Clipboard clip = Toolkit.getDefaultToolkit().getSystemClipboard();

        clip.setContents(new StringSelection(m_strKey), null);
        JOptionPane.showMessageDialog(m_frame, "Key successfully copied to clipboard!");
    }
}