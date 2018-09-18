-- ... 

local fields = {
    {"first name",  8,  "first%-name"},
    {"middle name", 8, "middle%-name"},
    {"last name",   8,   "last%-name"},
    {"book title",  8,  "book%-title"},
    {"publisher",   8,    "publisher"},
    {"city",        8,         "city"},
    {"year",        2,         "year"}
}

local limit = 256

-- https://stackoverflow.com/a/16627763

-- http://www.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP1251.TXT
local win2utf_list = [[
0x00	0x0000	#NULL
0x01	0x0001	#START OF HEADING
0x02	0x0002	#START OF TEXT
0x03	0x0003	#END OF TEXT
0x04	0x0004	#END OF TRANSMISSION
0x05	0x0005	#ENQUIRY
0x06	0x0006	#ACKNOWLEDGE
0x07	0x0007	#BELL
0x08	0x0008	#BACKSPACE
0x09	0x0009	#HORIZONTAL TABULATION
0x0A	0x000A	#LINE FEED
0x0B	0x000B	#VERTICAL TABULATION
0x0C	0x000C	#FORM FEED
0x0D	0x000D	#CARRIAGE RETURN
0x0E	0x000E	#SHIFT OUT
0x0F	0x000F	#SHIFT IN
0x10	0x0010	#DATA LINK ESCAPE
0x11	0x0011	#DEVICE CONTROL ONE
0x12	0x0012	#DEVICE CONTROL TWO
0x13	0x0013	#DEVICE CONTROL THREE
0x14	0x0014	#DEVICE CONTROL FOUR
0x15	0x0015	#NEGATIVE ACKNOWLEDGE
0x16	0x0016	#SYNCHRONOUS IDLE
0x17	0x0017	#END OF TRANSMISSION BLOCK
0x18	0x0018	#CANCEL
0x19	0x0019	#END OF MEDIUM
0x1A	0x001A	#SUBSTITUTE
0x1B	0x001B	#ESCAPE
0x1C	0x001C	#FILE SEPARATOR
0x1D	0x001D	#GROUP SEPARATOR
0x1E	0x001E	#RECORD SEPARATOR
0x1F	0x001F	#UNIT SEPARATOR
0x20	0x0020	#SPACE
0x21	0x0021	#EXCLAMATION MARK
0x22	0x0022	#QUOTATION MARK
0x23	0x0023	#NUMBER SIGN
0x24	0x0024	#DOLLAR SIGN
0x25	0x0025	#PERCENT SIGN
0x26	0x0026	#AMPERSAND
0x27	0x0027	#APOSTROPHE
0x28	0x0028	#LEFT PARENTHESIS
0x29	0x0029	#RIGHT PARENTHESIS
0x2A	0x002A	#ASTERISK
0x2B	0x002B	#PLUS SIGN
0x2C	0x002C	#COMMA
0x2D	0x002D	#HYPHEN-MINUS
0x2E	0x002E	#FULL STOP
0x2F	0x002F	#SOLIDUS
0x30	0x0030	#DIGIT ZERO
0x31	0x0031	#DIGIT ONE
0x32	0x0032	#DIGIT TWO
0x33	0x0033	#DIGIT THREE
0x34	0x0034	#DIGIT FOUR
0x35	0x0035	#DIGIT FIVE
0x36	0x0036	#DIGIT SIX
0x37	0x0037	#DIGIT SEVEN
0x38	0x0038	#DIGIT EIGHT
0x39	0x0039	#DIGIT NINE
0x3A	0x003A	#COLON
0x3B	0x003B	#SEMICOLON
0x3C	0x003C	#LESS-THAN SIGN
0x3D	0x003D	#EQUALS SIGN
0x3E	0x003E	#GREATER-THAN SIGN
0x3F	0x003F	#QUESTION MARK
0x40	0x0040	#COMMERCIAL AT
0x41	0x0041	#LATIN CAPITAL LETTER A
0x42	0x0042	#LATIN CAPITAL LETTER B
0x43	0x0043	#LATIN CAPITAL LETTER C
0x44	0x0044	#LATIN CAPITAL LETTER D
0x45	0x0045	#LATIN CAPITAL LETTER E
0x46	0x0046	#LATIN CAPITAL LETTER F
0x47	0x0047	#LATIN CAPITAL LETTER G
0x48	0x0048	#LATIN CAPITAL LETTER H
0x49	0x0049	#LATIN CAPITAL LETTER I
0x4A	0x004A	#LATIN CAPITAL LETTER J
0x4B	0x004B	#LATIN CAPITAL LETTER K
0x4C	0x004C	#LATIN CAPITAL LETTER L
0x4D	0x004D	#LATIN CAPITAL LETTER M
0x4E	0x004E	#LATIN CAPITAL LETTER N
0x4F	0x004F	#LATIN CAPITAL LETTER O
0x50	0x0050	#LATIN CAPITAL LETTER P
0x51	0x0051	#LATIN CAPITAL LETTER Q
0x52	0x0052	#LATIN CAPITAL LETTER R
0x53	0x0053	#LATIN CAPITAL LETTER S
0x54	0x0054	#LATIN CAPITAL LETTER T
0x55	0x0055	#LATIN CAPITAL LETTER U
0x56	0x0056	#LATIN CAPITAL LETTER V
0x57	0x0057	#LATIN CAPITAL LETTER W
0x58	0x0058	#LATIN CAPITAL LETTER X
0x59	0x0059	#LATIN CAPITAL LETTER Y
0x5A	0x005A	#LATIN CAPITAL LETTER Z
0x5B	0x005B	#LEFT SQUARE BRACKET
0x5C	0x005C	#REVERSE SOLIDUS
0x5D	0x005D	#RIGHT SQUARE BRACKET
0x5E	0x005E	#CIRCUMFLEX ACCENT
0x5F	0x005F	#LOW LINE
0x60	0x0060	#GRAVE ACCENT
0x61	0x0061	#LATIN SMALL LETTER A
0x62	0x0062	#LATIN SMALL LETTER B
0x63	0x0063	#LATIN SMALL LETTER C
0x64	0x0064	#LATIN SMALL LETTER D
0x65	0x0065	#LATIN SMALL LETTER E
0x66	0x0066	#LATIN SMALL LETTER F
0x67	0x0067	#LATIN SMALL LETTER G
0x68	0x0068	#LATIN SMALL LETTER H
0x69	0x0069	#LATIN SMALL LETTER I
0x6A	0x006A	#LATIN SMALL LETTER J
0x6B	0x006B	#LATIN SMALL LETTER K
0x6C	0x006C	#LATIN SMALL LETTER L
0x6D	0x006D	#LATIN SMALL LETTER M
0x6E	0x006E	#LATIN SMALL LETTER N
0x6F	0x006F	#LATIN SMALL LETTER O
0x70	0x0070	#LATIN SMALL LETTER P
0x71	0x0071	#LATIN SMALL LETTER Q
0x72	0x0072	#LATIN SMALL LETTER R
0x73	0x0073	#LATIN SMALL LETTER S
0x74	0x0074	#LATIN SMALL LETTER T
0x75	0x0075	#LATIN SMALL LETTER U
0x76	0x0076	#LATIN SMALL LETTER V
0x77	0x0077	#LATIN SMALL LETTER W
0x78	0x0078	#LATIN SMALL LETTER X
0x79	0x0079	#LATIN SMALL LETTER Y
0x7A	0x007A	#LATIN SMALL LETTER Z
0x7B	0x007B	#LEFT CURLY BRACKET
0x7C	0x007C	#VERTICAL LINE
0x7D	0x007D	#RIGHT CURLY BRACKET
0x7E	0x007E	#TILDE
0x7F	0x007F	#DELETE
0x80	0x0402	#CYRILLIC CAPITAL LETTER DJE
0x81	0x0403	#CYRILLIC CAPITAL LETTER GJE
0x82	0x201A	#SINGLE LOW-9 QUOTATION MARK
0x83	0x0453	#CYRILLIC SMALL LETTER GJE
0x84	0x201E	#DOUBLE LOW-9 QUOTATION MARK
0x85	0x2026	#HORIZONTAL ELLIPSIS
0x86	0x2020	#DAGGER
0x87	0x2021	#DOUBLE DAGGER
0x88	0x20AC	#EURO SIGN
0x89	0x2030	#PER MILLE SIGN
0x8A	0x0409	#CYRILLIC CAPITAL LETTER LJE
0x8B	0x2039	#SINGLE LEFT-POINTING ANGLE QUOTATION MARK
0x8C	0x040A	#CYRILLIC CAPITAL LETTER NJE
0x8D	0x040C	#CYRILLIC CAPITAL LETTER KJE
0x8E	0x040B	#CYRILLIC CAPITAL LETTER TSHE
0x8F	0x040F	#CYRILLIC CAPITAL LETTER DZHE
0x90	0x0452	#CYRILLIC SMALL LETTER DJE
0x91	0x2018	#LEFT SINGLE QUOTATION MARK
0x92	0x2019	#RIGHT SINGLE QUOTATION MARK
0x93	0x201C	#LEFT DOUBLE QUOTATION MARK
0x94	0x201D	#RIGHT DOUBLE QUOTATION MARK
0x95	0x2022	#BULLET
0x96	0x2013	#EN DASH
0x97	0x2014	#EM DASH
0x98	      	#UNDEFINED
0x99	0x2122	#TRADE MARK SIGN
0x9A	0x0459	#CYRILLIC SMALL LETTER LJE
0x9B	0x203A	#SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
0x9C	0x045A	#CYRILLIC SMALL LETTER NJE
0x9D	0x045C	#CYRILLIC SMALL LETTER KJE
0x9E	0x045B	#CYRILLIC SMALL LETTER TSHE
0x9F	0x045F	#CYRILLIC SMALL LETTER DZHE
0xA0	0x00A0	#NO-BREAK SPACE
0xA1	0x040E	#CYRILLIC CAPITAL LETTER SHORT U
0xA2	0x045E	#CYRILLIC SMALL LETTER SHORT U
0xA3	0x0408	#CYRILLIC CAPITAL LETTER JE
0xA4	0x00A4	#CURRENCY SIGN
0xA5	0x0490	#CYRILLIC CAPITAL LETTER GHE WITH UPTURN
0xA6	0x00A6	#BROKEN BAR
0xA7	0x00A7	#SECTION SIGN
0xA8	0x0401	#CYRILLIC CAPITAL LETTER IO
0xA9	0x00A9	#COPYRIGHT SIGN
0xAA	0x0404	#CYRILLIC CAPITAL LETTER UKRAINIAN IE
0xAB	0x00AB	#LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
0xAC	0x00AC	#NOT SIGN
0xAD	0x00AD	#SOFT HYPHEN
0xAE	0x00AE	#REGISTERED SIGN
0xAF	0x0407	#CYRILLIC CAPITAL LETTER YI
0xB0	0x00B0	#DEGREE SIGN
0xB1	0x00B1	#PLUS-MINUS SIGN
0xB2	0x0406	#CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
0xB3	0x0456	#CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
0xB4	0x0491	#CYRILLIC SMALL LETTER GHE WITH UPTURN
0xB5	0x00B5	#MICRO SIGN
0xB6	0x00B6	#PILCROW SIGN
0xB7	0x00B7	#MIDDLE DOT
0xB8	0x0451	#CYRILLIC SMALL LETTER IO
0xB9	0x2116	#NUMERO SIGN
0xBA	0x0454	#CYRILLIC SMALL LETTER UKRAINIAN IE
0xBB	0x00BB	#RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
0xBC	0x0458	#CYRILLIC SMALL LETTER JE
0xBD	0x0405	#CYRILLIC CAPITAL LETTER DZE
0xBE	0x0455	#CYRILLIC SMALL LETTER DZE
0xBF	0x0457	#CYRILLIC SMALL LETTER YI
0xC0	0x0410	#CYRILLIC CAPITAL LETTER A
0xC1	0x0411	#CYRILLIC CAPITAL LETTER BE
0xC2	0x0412	#CYRILLIC CAPITAL LETTER VE
0xC3	0x0413	#CYRILLIC CAPITAL LETTER GHE
0xC4	0x0414	#CYRILLIC CAPITAL LETTER DE
0xC5	0x0415	#CYRILLIC CAPITAL LETTER IE
0xC6	0x0416	#CYRILLIC CAPITAL LETTER ZHE
0xC7	0x0417	#CYRILLIC CAPITAL LETTER ZE
0xC8	0x0418	#CYRILLIC CAPITAL LETTER I
0xC9	0x0419	#CYRILLIC CAPITAL LETTER SHORT I
0xCA	0x041A	#CYRILLIC CAPITAL LETTER KA
0xCB	0x041B	#CYRILLIC CAPITAL LETTER EL
0xCC	0x041C	#CYRILLIC CAPITAL LETTER EM
0xCD	0x041D	#CYRILLIC CAPITAL LETTER EN
0xCE	0x041E	#CYRILLIC CAPITAL LETTER O
0xCF	0x041F	#CYRILLIC CAPITAL LETTER PE
0xD0	0x0420	#CYRILLIC CAPITAL LETTER ER
0xD1	0x0421	#CYRILLIC CAPITAL LETTER ES
0xD2	0x0422	#CYRILLIC CAPITAL LETTER TE
0xD3	0x0423	#CYRILLIC CAPITAL LETTER U
0xD4	0x0424	#CYRILLIC CAPITAL LETTER EF
0xD5	0x0425	#CYRILLIC CAPITAL LETTER HA
0xD6	0x0426	#CYRILLIC CAPITAL LETTER TSE
0xD7	0x0427	#CYRILLIC CAPITAL LETTER CHE
0xD8	0x0428	#CYRILLIC CAPITAL LETTER SHA
0xD9	0x0429	#CYRILLIC CAPITAL LETTER SHCHA
0xDA	0x042A	#CYRILLIC CAPITAL LETTER HARD SIGN
0xDB	0x042B	#CYRILLIC CAPITAL LETTER YERU
0xDC	0x042C	#CYRILLIC CAPITAL LETTER SOFT SIGN
0xDD	0x042D	#CYRILLIC CAPITAL LETTER E
0xDE	0x042E	#CYRILLIC CAPITAL LETTER YU
0xDF	0x042F	#CYRILLIC CAPITAL LETTER YA
0xE0	0x0430	#CYRILLIC SMALL LETTER A
0xE1	0x0431	#CYRILLIC SMALL LETTER BE
0xE2	0x0432	#CYRILLIC SMALL LETTER VE
0xE3	0x0433	#CYRILLIC SMALL LETTER GHE
0xE4	0x0434	#CYRILLIC SMALL LETTER DE
0xE5	0x0435	#CYRILLIC SMALL LETTER IE
0xE6	0x0436	#CYRILLIC SMALL LETTER ZHE
0xE7	0x0437	#CYRILLIC SMALL LETTER ZE
0xE8	0x0438	#CYRILLIC SMALL LETTER I
0xE9	0x0439	#CYRILLIC SMALL LETTER SHORT I
0xEA	0x043A	#CYRILLIC SMALL LETTER KA
0xEB	0x043B	#CYRILLIC SMALL LETTER EL
0xEC	0x043C	#CYRILLIC SMALL LETTER EM
0xED	0x043D	#CYRILLIC SMALL LETTER EN
0xEE	0x043E	#CYRILLIC SMALL LETTER O
0xEF	0x043F	#CYRILLIC SMALL LETTER PE
0xF0	0x0440	#CYRILLIC SMALL LETTER ER
0xF1	0x0441	#CYRILLIC SMALL LETTER ES
0xF2	0x0442	#CYRILLIC SMALL LETTER TE
0xF3	0x0443	#CYRILLIC SMALL LETTER U
0xF4	0x0444	#CYRILLIC SMALL LETTER EF
0xF5	0x0445	#CYRILLIC SMALL LETTER HA
0xF6	0x0446	#CYRILLIC SMALL LETTER TSE
0xF7	0x0447	#CYRILLIC SMALL LETTER CHE
0xF8	0x0448	#CYRILLIC SMALL LETTER SHA
0xF9	0x0449	#CYRILLIC SMALL LETTER SHCHA
0xFA	0x044A	#CYRILLIC SMALL LETTER HARD SIGN
0xFB	0x044B	#CYRILLIC SMALL LETTER YERU
0xFC	0x044C	#CYRILLIC SMALL LETTER SOFT SIGN
0xFD	0x044D	#CYRILLIC SMALL LETTER E
0xFE	0x044E	#CYRILLIC SMALL LETTER YU
0xFF	0x044F	#CYRILLIC SMALL LETTER YA
]]

local win2utf = {}

for w, u in win2utf_list:gmatch'0x(%x%x)%s+0x(%x+)' do
    local c, t, h = tonumber(u, 16), {}, 128
    while c >= h do
        t[#t + 1] = 128 + c%64
        c = math.floor(c / 64)
        h = h > 32 and 32 or h / 2
    end
    t[#t + 1] = 256 - 2 * h + c
    win2utf[w.char(tonumber(w, 16))] = 
    w.char((table.unpack or unpack)(t)):reverse()
end


function ContentGetSupportedField(FieldIndex)
    if (fields[FieldIndex + 1] ~= nil) then
        return fields[FieldIndex + 1][1], "", fields[FieldIndex + 1][2];
    end
    return '', '', 0; -- ft_nomorefields
end

function ContentGetDetectString()
    return '(EXT="XML")|(EXT="FB2")'; -- return detect string
end

function ContentGetValue(FileName, FieldIndex, UnitIndex, flags)
    if (SysUtils.DirectoryExists(FileName)) then
        return nil;
    end
    local is1251 = false
    if (fields[FieldIndex + 1][3] ~= nil ) then
        local file = io.open(FileName, "r");
        if file then
            for line in file:lines() do
                if (line:len() < limit) then
                    if (string.find(line, 'encoding="windows%-1251"')) then
                        is1251 = true;
                    elseif (string.find(line, '<' .. fields[FieldIndex + 1][3] .. '>')) then
                        file:close();
                        return cutval(line, fields[FieldIndex + 1][3], is1251);
                    end
                else
                    for i = 1, line:len() - limit, limit do
                        local part = string.sub(line, i, i + limit - 1);
                        if (string.find(part, 'encoding="windows%-1251"')) then
                            is1251 = true;
                        elseif (string.find(part, '<' .. fields[FieldIndex + 1][3] .. '>')) then
                            file:close();
                            return cutval(part, fields[FieldIndex + 1][3], is1251);
                        end
                        
                    end
                end
            end
            file:close();
        end
    end
    return nil;
end

function cutval(src, str, ecn)
    local result = string.gsub(src, '.*<' .. str .. '>%s*' , "");
    result = result:gsub('%s*</.*', "");
    if  (ecn == true) then
        return result:gsub('.', win2utf);
    else
        return result;
    end
end
