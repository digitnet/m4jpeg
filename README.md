M4JPEG project aims to build a Matlab-compiled steganography tool working in the field of JPEG images. The provided M4JPEG tool lets the user hide a private file within a JPEG image using an adaptive steganographic method called Mod4.

# About The Current Version -  Ver 1.4:

- The current version of M4JPEG doesn’t include an encryption layer, thus the file we want to hide is not encrypted before the embedding process. But, the hiding layer is protected by using a key-based permutation generator.
- The permutation generator is based on a Matlab built-in pseudo-random generator.
- The current version of M4JPEG only uses the parameters M4[1,1,1,1].
- Only the extension AND the size of the embedded file are stored directly in the cb and cr components of the generated Stego JPEG file.