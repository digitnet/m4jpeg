


****** README FILE ******


ABOUT M4JPEG:
-------------

M4JPEG project aims to build and develop a FREE Matlab-compiled steganography tool working in the field of JPEG images.
The provided M4JPEG tool lets the user hide a private file within a JPEG image using an adaptive steganographic method called Mod4[1].


ABOUT THE CURRENT VERSION (M4JPEG Ver 1.4) - STARTING VERSION:
--------------------------------------------------------------


1-	The current version of M4JPEG doesn�t include an encryption layer, thus the file we want to hide is not encrypted before the embedding process. 
        The security of the hiding layer is performed by using a key-based permutation generator.

2-	The permutation generator is based on a Matlab built-in pseudo-random generator.

3-	The current version of M4JPEG only uses the parameters M4[1,1,1,1].

4-	Only the extension AND the size of the embedded file are stored directly in the cb and cr components of the generated Stego JPEG file.

5-	The main used key (at least 12 Char) is NOT saved or stored in any form in the generated Stego JPEG file.
        Thus, during the extraction process, M4JPEG can not recognize whether the entered key matches the used one.
        If the entered key is not the same as the used one, the extracted file will contain meaningless data (rubbish).

6-	We use the toolbox of Phil Sallee[2]. Sallee�s toolbox makes easier to access and manipulate the qDCT coefficients of 
        a given JPEG file. The main two functions perform the standard steps of lossless compression, including Huffman Coding and decoding.


FUTURE Work:
------------
 
1-	Building a stronger key-based permutation generator.

2-	Using more parameters of the MOD4 method.

3-	Adding other methods such as the F5 method.

4-	Adding an encryption layer in addition to the steganography layer.


WEBSITE:
--------

Basic Diagrams, GUI Screenshots, and Binaries Download are accessed from the Home Page:

http://m4jpeg.digitalsd.net



REFERENCES:
----------


[1]      KokSheik Wong, Xiaojun Qi, Kiyoshi Tanaka. �A DCT-based Mod4 
         Steganographic Method�: Signal Processing 87, 1251�1263, 2007.

[2]      Phil Sallee. �Matlab JPEG Toolbox�: Original package: jpegtbx_1.4, Sep 2003.
         Download link: http://dde.binghamton.edu/download/jpeg_toolbox.zip
         The new package includes a few pre-compiled versions.