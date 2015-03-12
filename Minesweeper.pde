import de.bezier.guido.*;
public boolean gameOver = false;
public final static int NUM_COLS = 40;
public final static int NUM_ROWS = 40;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();
void setup ()
{
    size(640, 640);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    /*make apartments*/ buttons = new MSButton[40][40];
    for (int row = 0; row < 40; row ++)
    {
        for (int col = 0; col < 40; col ++)
        {
         /*fill apartments*/ buttons[row][col] = new MSButton(row,col);
     }
 }

 setBombs();
}
public void setBombs()
{
    for (int b = 0; b < 240; b++) //number of bombs
    {
    int r = ((int)(Math.random()*NUM_ROWS));
    int c = ((int)(Math.random()*NUM_COLS));
    if (!(bombs.contains(buttons[r][c])))
    {
        bombs.add(buttons[r][c]);
    }
    else
    {
        b --;
    }
}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
      for (int row = 0; row < 40; row ++)
    {
        for (int col = 0; col < 40; col ++)
        {
            if (!buttons[row][col].isMarked()&&!buttons[row][col].isClicked())
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
   
  gameOver = true;
   
}
public void displayWinningMessage()
{
  
   buttons[20][16].setLabel("Y");
   buttons[20][17].setLabel("O");
   buttons[20][18].setLabel("U");
   
   buttons[20][20].setLabel("W");
   buttons[20][21].setLabel("I");
   buttons[20][22].setLabel("N");
   buttons[20][23].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 640/NUM_COLS;
        height = 640/NUM_ROWS;
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
    
    public void mousePressed () 
    {
        if (marked)
        {
 if (mousePressed == true && mouseButton == RIGHT && label == "")
        {
            marked = !marked;
        }
        }
        else
        {
            clicked = true;
        if (mousePressed == true && mouseButton == RIGHT && label == "")
        {
            marked = !marked;
            clicked = false;
        }
        else if (bombs.contains( this ))
        {
            displayLosingMessage();
        }
else if(countBombs(r,c) > 0)
{
    label = "" + countBombs(r,c);
}
else
{
    for (int rr = -1; rr < 2; rr ++)
    {
        for(int cc = -1; cc < 2; cc++)
        {
            if(isValid(r + rr, c + cc) && buttons[r+rr][c+cc].isClicked() == false)
{
buttons[r+rr][c+cc].mousePressed();
    
}

        }
    }
       //  * else recursively call `mousePressed` with the valid, unclicked, neighboring buttons 
}
}
    }

    public void draw () 
    {    
        if (marked)
        {
            fill(255,255,0);
            // label = "?";
        }

        else if( clicked && bombs.contains(this) ) 
        {
            label = ":(";
            fill(255,0,0);
        } 
        else if(clicked)
        {
            fill( 200 );
        }
        else 
        {
            fill( 100 );
        }
if (gameOver)
{
    pushStyle();
    fill((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
    textSize(40);
     text("GAME OVER HAHAHAHA",350,200+(int)(Math.random()*10-5));
     popStyle();
    rect(0,0,width,height);
    x += (int)(Math.random()*4-2);
    y += (int)(Math.random()*4-2);
    label = "" + (int)(Math.random()*99);
   
}
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
        if (r < 40 && c < 40 & r >= 0 && c >= 0)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;

        if (isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
        {
            numBombs ++;
        }
        if (isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
        {
            numBombs ++;
        }
        if (isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
        {
            numBombs ++;
        }
        if (isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
        {
            numBombs ++;
        }
        if (isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
        {
            numBombs ++;
        }
        if (isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
        {
            numBombs ++;
        }
        if (isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
        {
            numBombs ++;
        }
        if (isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
        {
            numBombs ++;
        }
        return numBombs;
    }
    


}



