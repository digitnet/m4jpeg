M4JPEG project aims to build a Matlab-compiled steganography tool working in the field of JPEG images. The provided M4JPEG tool lets the user hide a private file within a JPEG image using an adaptive steganographic method called Mod4.

# About The Current Version -  Ver 1.4:

- The current version of M4JPEG doesn’t include an encryption layer, thus the file we want to hide is not encrypted before the embedding process. But, the hiding layer is protected by using a key-based permutation generator.
- The permutation generator is based on a Matlab built-in pseudo-random generator.
- The current version of M4JPEG only uses the parameters M4[1,1,1,1].
- Only the extension AND the size of the embedded file are stored directly in the cb and cr components of the generated Stego JPEG file.
- The main used key (at least 12 Char) is NOT saved or stored in any form in the generated Stego JPEG file. Thus, during the extraction process, M4JPEG can NOT recognize whether the entered key matches the used one. If the entered key is NOT the same as the used one, the extracted file will contain meaningless data.
- We use the toolbox of Phil Sallee[2]. Sallee’s toolbox makes easier to access and manipulate the qDCT coefficients of a given JPEG file. The main two functions perform the standard steps of lossless compression, including Huffman Coding and decoding.
