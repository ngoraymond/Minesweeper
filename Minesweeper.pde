

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    bombs=new ArrayList<MSButton>();
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows=0;rows<NUM_ROWS;rows++)
        for(int column=0;column<NUM_COLS;column++)
           {
                buttons[rows][column]=new MSButton(rows,column);
           }
    for(int i=0;i<50;i++)
        setBombs();
}
public void setBombs()
{
    //your code
    int randX=(int)(Math.random()*20);
    int randY=(int)(Math.random()*20);
    if(!bombs.contains(buttons[randX][randY]))
        bombs.add(buttons[randX][randY]);
    else 
        setBombs();
        
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here

    return false;
}
public void displayLosingMessage()
{
    for(int i=0;i<NUM_ROWS;i++)
        for(int j=0;j<NUM_COLS;j++)
        {
            buttons[i][j].setClicked();
            if(!bombs.contains(buttons[i][j]))
                buttons[i][j].setLabel(":(");
        }
    /*
    for(int i=0;i<bombs.size();i++)
        bombs.get(i).setClicked();
    */

}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    public void setClicked()
    {
        if(!clicked)
            clicked=true;
    }
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed)
        {
            marked=!marked;
            if(!marked)
                clicked=false;
        }
        else if (bombs.contains(this))
            displayLosingMessage();
        else if (countBombs(r,c)>0)
            setLabel(str(countBombs(r,c)));
        else
        {
            for(int i=-1;i<2;i++)
                for(int j=-1;j<2;j++)
                    if(isValid(r+i,c+j))
                        if(!buttons[r+i][c+j].isClicked())
                            buttons[r+i][c+j].mousePressed();
        }


    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<NUM_ROWS && c<NUM_COLS && r>-1 && c>-1)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int j=-1;j<2;j++)
            for(int k=-1;k<2;k++)
                if(isValid(row+j,col+k))
                    if(bombs.contains(buttons[row+j][col+k]))
                        numBombs++;
        return numBombs;
    }
}



