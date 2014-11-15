#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;Copyright © 2014 Roy Pfund                                 All rights reserved.
;Use of this software and associated documentation  files  (the  "Software"), is
;governed by a MIT-style License(the "License") that can be found in the LICENSE
;file. You should have received a copy of the License along with this Software.
;If not, see http://Viruliant.googlecode.com/git/LICENSE.txt
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/AmyAhS SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(define-syntax λ (syntax-rules () ((_ param body ...) (lambda param body ...))))
(define user-initial-environment (scheme-report-environment 5))(define false #f)
(define true #t)(define (inc x)(+ x 1))(define (dec x)(- x 1))(define nil '())
(define (atom? x) (not (pair? x)))(define (stream-null? x) (null? x))
(define (identity x) x)(define the-empty-stream '())(define mapcar map)
(define-syntax cons-stream (syntax-rules () ((_ A B) (cons A (delay B)))))
;___________________________________________________________________________xtra
(define (current-continuation) (call/cc (λ (cc) (cc cc))))
(define (display-all . x)(for-each display x))
;________________________________________________________________________RFC3629
(define (24bit x) (bitor x #x000000))
(define (32bit x) (bitor x #x00000000))
(define (64bit x) (bitor x #x0000000000000000))
(define (96bit x) (bitor x #x000000000000000000000000))
(define (192bit x) (bitor x #x000000000000000000000000000000000000000000000000))
;Valid Chars & their Corresponding Valid Sequences
;Char. number range  |        UTF-8 octet sequence
;   (hexadecimal)    |              (binary)
;--------------------+---------------------------------------------
;0000 0000-0000 007F | 0xxxxxxx
;0000 0080-0000 07FF | 110xxxxx 10xxxxxx
;0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
;0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

(define (PutUTF8Char thechar)
	;arguments:
	;errors   :
	;Inputs   : a 24bit typecasted 21 bit unicode char < #x110000
	;Output(s): 1-4 calls putbyte() writing thechar in utf8
	(define (writeContinuingOctet)
		(putbyte (bitor #x80 (bitand #x3F thechar))
		thechar = rol(thechar, 6))
	(cond
		((< thechar #x80);1 byte character
			(putbyte thechar)
		((< thechar #x800)(;2 byte character
			thechar = ror(thechar, 6); putbyte((uint8_t)thechar bitor #xC0)
			(writeContinuingOctet)
		((< thechar #x10000)(;3 byte character
			thechar = ror(thechar, 12); putbyte((uint8_t)thechar bitor #xE0)
			(writeContinuingOctet)
			(writeContinuingOctet)
		((< thechar #x110000)(;4 byte character
			thechar = ror(thechar, 18)
			putbyte(((uint8_t)thechar bitand #x07) bitor #xF0)
			(writeContinuingOctet)
			(writeContinuingOctet)
			(writeContinuingOctet)
		(else (return error))));invalid character

(define (GetUTF8Char)(call/cc (λ (return)
	;arguments:
	;errors   :
	;Inputs   : the next 1-4 bytes taken from the getbyte() function are a valid RFC3629 sequence. or getbyte() returns EOF.
	;Output(s): error OR a 24bit typecasted 21 bit Unicode Code-Point < #x110000.
	(define (ReadContinuingOctet)
		(set! CurrentOctet (bitwise-xor #x80 (getbyte)))
		(if (< CurrentOctet #x40);continuing byte sequence
			(set! thechar (+ CurrentOctet (arithmetic-shift-left thechar 6))
			(return error))
	(set! thechar (24bit 0))
	(set! CurrentOctet (getbyte))
	(cond ; 6 scenarios for 1st input byte
		((< CurrentOctet #x80) (return (24bit CurrentOctet)));1 byte sequence
		((< CurrentOctet #xC2) (return error));invalid byte sequence
		((< (bitwise-xor #xC0 CurrentOctet) #x20);2 byte sequence
			(set! thechar (24bit (bitwise-xor #xC0 CurrentOctet)))
			(ReadContinuingOctet)
			(if (< thechar #x80) (return error));overlong(small char using excessive bytes)
			(return thechar))
		((< (bitwise-xor #xE0 CurrentOctet) #x10);3 byte sequence
			(set! thechar (24bit (bitwise-xor #xE0 CurrentOctet)))
			(ReadContinuingOctet)
			(ReadContinuingOctet)
			(if (< thechar #x800) (return error));overlong
			(return thechar))
		((< (bitwise-xor #xF0 CurrentOctet) #x08);4 byte sequence
			(set! thechar (24bit (bitwise-xor #xF0 CurrentOctet)))
			(ReadContinuingOctet)
			(ReadContinuingOctet)
			(ReadContinuingOctet)
			(if (< thechar #x10000) (return error));overlong
			(if (> thechar #x110000) (return error));thechar is too large
			(return thechar))
		(else (return error)));invalid byte sequence
))

