using Gtk;
using System;

public class Win95Keygen {
        
    private const string m_strLabelText = "Key: ";
    private static string m_strKey = "";
    private static Label m_labKey = new Label();
    private static Window m_window = new Window ("C# W95 Keygen");
    static void Main()
    {
        Application.Init ();
        m_labKey = new Label(m_strLabelText + m_strKey);
        Button btnGen = new Button("Generate Key");
        Button btnCopy = new Button("Copy to clipboard");

        VBox vb = new VBox(true, 10);
        HBox hb = new HBox(true, 10);

        btnGen.Clicked += new EventHandler(GenerateOemKey);
        btnCopy.Clicked += new EventHandler(CopyToClip);

        m_window.DeleteEvent += delete_event;

        m_window.Add(vb);
        
        vb.Add(m_labKey);
        vb.Add(hb);
        
        hb.Add(btnGen);
        hb.Add(btnCopy);

        m_window.ShowAll ();

        Application.Run ();
    }


    static void delete_event (object? obj, DeleteEventArgs args)
    {
        Application.Quit ();
    }
    
    static void GenerateOemKey (object? obj, EventArgs args)
    {
        Random rng = new Random();
        int iDay, iYear, iUnchecked;
        iDay = rng.Next()%367;
        iYear = (95+(rng.Next()%8))%100;
        iUnchecked = rng.Next()%100000;

        int[] iMod7Table = new int[5];
        int iCount = 0;
        int iMod7 = 0;

        do{
            Array.Clear(iMod7Table);
            iCount = 0;

            for(int i=0; i<5; i++){
                iMod7Table[i] = rng.Next()%10;
                iCount += iMod7Table[i];
            }

        }while((iCount%7)!=0);

        for(int i=0; i<5; i++){
            iMod7*=10;
            iMod7+=iMod7Table[i];
        }

        m_strKey = String.Format("{0:D3}{1:D2}-OEM-00{2:D5}-{3:D5}", iDay, iYear, iMod7, iUnchecked);
        m_labKey.Text = m_strLabelText + m_strKey;
    }
    static void CopyToClip (object? obj, EventArgs args){
        Gtk.Clipboard.Get(Gdk.Atom.Intern("CLIPBOARD", true)).Text = m_strKey;
        MessageDialog md = new MessageDialog(m_window, DialogFlags.DestroyWithParent, MessageType.Info, ButtonsType.Close, false, "Key successfully copied!");
        md.Run();
        md.Destroy();
    }
}