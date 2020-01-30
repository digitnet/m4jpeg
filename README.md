

ABOUT M4JPEG:
-------------

M4JPEG project aims to build and develop a Matlab-compiled steganography tool working in the field of JPEG images.
The provided M4JPEG tool lets the user hide a private file within a JPEG image using an adaptive steganographic method called Mod4[1].

[![View M4JPEG on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://uk.mathworks.com/matlabcentral/fileexchange/74063-m4jpeg)


THE EXISTING FOLDERS:
---------------------

*block_diagram*: Contains the basic block diagrams of embedding and extracting processes.

*gui_screenshots*: Contains the main screenshots.

*phil_sallee_toolbox*: Contains the Sallee's toolbox.

*src_code*: Contains the source code;  .m , .fig, and .mexwXX files.

NOTES ABOUT USE:
----------------

1- The StartGUI files (.m, .fig) are the starting ones. StartGUI.m represents the main GUI that calls all other GUIs and required functions.

2- The pre-compiled MEX files (.mexwXX) perform the lossless compression steps including the entropy coding and decoding. The zip file of jpeg_toolbox contains pre-Matlab-compiled MEX files according to 
several systems.


ABOUT THE CURRENT VERSION - M4JPEG Ver 1.4:
-------------------------------------------

1-	The current version of M4JPEG doesn’t include an encryption layer, thus the file we want to hide is not encrypted before the embedding process.
        But, the hiding layer is protected by using a key-based permutation generator.

2-	The permutation generator is based on a Matlab built-in pseudo-random generator.

3-	The current version of M4JPEG only uses the parameters M4[1,1,1,1].

4-	Only the extension AND the size of the embedded file are stored directly in the cb and cr components of the generated Stego JPEG file.

5-	The main used key (at least 12 Char) is NOT saved or stored in any form in the generated Stego JPEG file.
        Thus, during the extraction process, M4JPEG can NOT recognize whether the entered key matches the used one.
        If the entered key is NOT the same as the used one, the extracted file will contain meaningless data.

6-	We use the toolbox of Phil Sallee[2]. Sallee’s toolbox makes easier to access and manipulate the qDCT coefficients of 
        a given JPEG file. The main two functions perform the standard steps of lossless compression, including Huffman Coding and decoding.


REFERENCES:
----------

[1]      KokSheik Wong, Xiaojun Qi, Kiyoshi Tanaka. “A DCT-based Mod4 
         Steganographic Method”: Signal Processing 87, 1251–1263, 2007.

[2]      Phil Sallee. “Matlab JPEG Toolbox”,Sep 2003.
         Download link: http://dde.binghamton.edu/download/jpeg_toolbox.zip

