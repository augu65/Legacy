-- By: Jonah Stegman
-- Course: CIS*3190
-- scrammble words using ada
with ada.Text_IO; use ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
procedure wordscram is 
    -- gets the filename from the user
    function getFilename return string is
        file : string (1..100);
        size: Natural;
    begin
        put_line("Enter the file name: "); 
        get_line(file,size);  
        return file(1..size);
    end getFilename;
    userfile: string:=getFilename;
begin
    put_line(userfile);
end wordscram;


--function processText()
--begin
--end processText;

--function scrambleWord()
--begin
--end scrambleWord;

--function randomInt() return integer is
--    num: integer
--begin
--end randomInt;

--function isWord() return boolean is
--begin
--end isWord;