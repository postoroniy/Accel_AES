// Copyright (c) 2015-2017 Bluespec, Inc.  All Rights Reserved
// Author: Rishiyur S. Nikhil (Bluespec, Inc.)

// ================================================================
// This code defines standard parameters for AES: Nb, Nk

// Specs for this code:
//  - AES.cry in Cryptol distribution.
//         cf. "Programming Cryptol", book from Galois, Inc. (galois.com)
//         Book and Cryptol distribution containing AES.cry downloaded from:
//         http://cryptol.net
//  - AES.bsv in BSV
//         Direct transliteration of AES.cry from Cryptol to BSV
//         (no HW considaration; expands into a huge combinational ckt)

// Note: A line here beginning with '// CR nn' is a copy of line nn in
// AES.cry

// ================================================================

package AES_Params;

// ================================================================
// imports from BSV lib

// None

// ----------------------------------------------------------------
// imports for this project

// None

// ================================================================
// CR 15 type AES128 = 4
// CR 16 type AES192 = 6
// CR 17 type AES256 = 8
typedef  4  AES128;
typedef  6  AES192;
typedef  8  AES256;

// CR 18
// CR 19 type Nk = AES128
// typedef  AES128  Nk;
// typedef  AES192  Nk;
typedef AES256  Nk;
Integer nk = valueOf (Nk);

// CR 24
// CR 25 // Number of blocks and Number of rounds
// CR 26 typeNb=4
// CR 27 typeNr=6+Nk

typedef 4  Nb;
Integer nb = valueOf (Nb);
typedef TAdd #(6, Nk)  Nr;    // 10, 12, 14
Integer nr = valueOf (Nr);

//number of rounds for encrypt/decrypt
typedef TAdd #(6, AES128)  Nr_AES128;
typedef TAdd #(6, AES192)  Nr_AES192;
typedef TAdd #(6, AES256)  Nr_AES256;

//indexes during of key expansion rounds
typedef AES128                                   Nrmin_AES128;
typedef TMul #(TAdd #( TAdd #(6, AES128),1),Nb)  Nrmax_AES128;

typedef AES192                                   Nrmin_AES192;
typedef TMul #(TAdd #( TAdd #(6, AES192),1),Nb)  Nrmax_AES192;

typedef AES256                                   Nrmin_AES256;
typedef TMul #(TAdd #( TAdd #(6, AES256),1),Nb)  Nrmax_AES256;


// CR 28
// CR 29 type AESKeySize = (Nk*32)
// CR 30

typedef TMul #(Nk, 32) AESKeySize;    // 128, 192, 256

// ================================================================

endpackage
