program RestoPorSubtracao;

function Resto(a, b: integer): integer;
begin
    if a < b then
        Resto := a
    else
        Resto := Remainder(a - b, b);
end;

var
    a, b, r: integer;
begin
    writeln('Introduza a:');
    readln(a);

    writeln('Introduza b:');
    readln(b);

    if b <= 0 then
        writeln('O divisor deve ser positivo.')
    else
        begin
            r := Resto(a, b);
            writeln('O resto da divisão inteira de ', a, ' por ', b, ' é: ', r);
        end;
end.
