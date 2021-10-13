with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with dcola;-- no podem fer un use pq es un paquet generic

procedure Main is
   --DECLARACIONS
   subtype tnom is String(1..50);
   type tjugador is record
      nom: tnom;
      l: Natural;
   end record;

   package dcolaS is new dcola(tjugador);
   use dcolaS;
   c: cola;

   FitxerIn: File_Type;
   player: tjugador;
   passades: Integer:= 0;

begin
   --Inicialitzam la coa
   cvacia(c);
   --Obrim el fitxer de jugadors
   Open(File => FitxerIn,
        Mode => In_File,
        Name => "jugadores.txt");

   --Llegim els jugadors desde el fitxer i els posam a la coa
   while not End_Of_File(FitxerIn) loop
      Get_Line(FitxerIn,player.nom,player.l);
      poner(c,player);
   end loop;
   Close(FitxerIn);
   --Demanam a l usuari quantes passades vol fer
   Put_line("Introdueix el numero de passades");
   passades := Integer'value(Get_Line);
   --Anam iterant fins que només quedi un jugador
   while not is_last_item(c) loop
      for i in 1..passades loop
         player:= coger_primero(c);
         poner(c,player);
         borrar_primero(c);
      end loop;
      --Despres de les passades eliminam al  que està al principi
      borrar_primero(c);
   end loop;
   player:= coger_primero(c);
   Put_Line("Ha guanyat: "&player.nom(1..player.l));

end Main;
