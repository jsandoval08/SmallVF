'Hit the Keypad for the Bullets To Appear 

'Initiate Graphics
Graphics 800,600

'Set AutoMidHandle to true
AutoMidHandle True

'TYPES

'Bullet type - holds the information for each bullet
Type TBullet
	Field x,y 'the coordinates of the bullet
End Type

'Player type - holds the actual player
Type TPlayer
	Field x,y 'the coordinates of the player
End Type

'Create player and initialize fields
Global player:TPlayer = New TPlayer
player.x = 400
player.y = 500

'Create a list to hold bullets
Global bulletlist:TList = CreateList()

'IMAGES
Global playerimage:TImage = LoadImage("ship.bmp")
Global bulletimage:TImage = LoadImage("bullet.bmp")
Global backgroundimage:TImage = LoadImage("stars.bmp")

'Create a scrolling indicator variable
Global scrolly:Int = 0

'MAIN LOOP
While Not KeyDown(KEY_ESCAPE)
    Cls

    'Increment scrolling variable
    scrolly = scrolly + 1

    'Tile the background
    TileImage backgroundimage, 0, scrolly

    'Reset the scrolling variable when it grows too large
    If scrolly > ImageHeight(backgroundimage)
        scrolly = 0
    EndIf

    'Test input keys
    TestKeys()

    'Update (move) each bullet
    UpdateBullets()

    'Draw the player
    DrawImage playerimage, player.x, player.y

    'Wait a bit
    Delay 50

    'Flip the front and back buffers
    Flip

Wend 'END OF MAIN LOOP

'FUNCTIONS
'Function TestKeys() - Tests what buttons have been pressed by the player
Function TestKeys()

    'If the player hits up, we move him 5 pixels up
    If KeyDown(KEY_UP)
        player.y = player.y - 5 'move player 5 pixels up
    EndIf

    'If the player hits left, we move him 5 pixels left
    If KeyDown(KEY_LEFT)
        player.x = player.x - 5 'move player 5 pixels left
    EndIf

    'If the player hits right, we move him 5 pixels right
    If KeyDown(KEY_RIGHT)
        player.x = player.x + 5 'move player 5 pixels right
    EndIf

    'If the player hits down, we move him 5 pixels down
    If KeyDown(KEY_DOWN)
        player.y = player.y + 5 'move player 5 pixels down
    EndIf

    'If the player hits spacebar, create a new bullet at the player's current position
    If KeyHit(KEY_SPACE)
        Local bullet:TBullet = New TBullet
        bullet.x = player.x
        bullet.y = player.y
        ListAddLast bulletlist, bullet
    EndIf

End Function

'Function UpdateBullets() - Moves each bullet on screen
Function UpdateBullets()

    'For every bullet, move it up 5 pixels. If it goes offscreen, delete it; otherwise, draw it
    For Local bullet:TBullet = EachIn bulletlist
        bullet.y = bullet.y - 5 'Move bullet up

        'If bullet moves offscreen, delete it; otherwise, draw it onscreen
        If bullet.y < 0
            ListRemove bulletlist, bullet
        Else
            DrawImage bulletimage, bullet.x, bullet.y 'Draw the bullet
        EndIf
    Next 'move to next bullet

End Function
