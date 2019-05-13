; Factorizes x into a product of prime factors.
; x is represented into the edi (32bit) register.

.intel_syntax noprefix
.text
.global factorize
.type   factorize, @function

            mov r8, 1           ; R8 = prime factor dividing the number x. Starts at 2. (Increased each time so initial value has to be 1).

mainloop:                       ; Main loop, runs after a complete division of each prime factor. 
            cmp edi, 1          ; Compare the number with 1.
            jbe end             ; If the number equals 1 (or below but shouldn't happen except given as so), end the function.
            mov r9, 0           ; Used in dividing the number edi as the result.
            mov esi, edi        ; Copy the content of edi into esi to do the division, so we keep the value of edi the same.
            
divloop:                        ; Dividing loop. Divides x by the current factor until the modulo is different from 0.
            cmp esi, r8         ; Compare the number with the divider.
            jb enddiv           ; if number < divider then the division has ended. esi is the rest and R9 is the result.
            sub esi, r8         ; Substract the divider to the number being divided.
            inc r9              ; Increase R9, which counts the amount of times we've divided. (= Result of division)
            jmp divloop         ; Start again.

enddiv:                         ; Executed at the end of the division. esi = rest. R9 = result.
            cmp esi, 0          ; Compare the rest with 0 (Check the modulo).
            jne faildiv         ; if it's different. It means we can't divide by this factor anymore. We skip it and go to the next factor.
            ; Call printf C     ; The modulo is 0. We print the factor by calling C's printf method.
            mov edi, r9         ; We change edi to the result of the division by R8.
            jmp mainloop        ; Start again with the same factor.

faildiv:
            inc r8              ; Goes to the next factor.
            jmp mainloop        ; Start again with the new factor.

end:                            ; End the program. Nothing to return.
            ret                
