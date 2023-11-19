

void setup() {

  String DNA = "TAC TAG TAA CCA CAA";
  String compressedDNA = "";
  String compressedmRNA = "";

  String [][] codons = new String [][]{
    {"Phenylalanine", "UUU", "UUC"},
    {"Leucine", "UUA", "UUG", "CUU", "CUC", "CUA", "CUG"},
    {"Isoleucine", "AUU", "AUC", "AUA"},
    {"Methionine(Start)", "AUG"},
    {"Valine", "GUU", "GUC", "GUA", "GUG"},
    {"Serine", "UCU", "UCC", "UCA", "UCG", "AGU", "AGC"},
    {"Proline", "CCU", "CCC", "CCA", "CCG"},
    {"Threonine", "ACU", "ACC", "ACA", "ACG"},
    {"Alanine", "GCU", "GCC", "GCA", "GCG"},
    {"Glycine", "GGU", "GGC", "GGA", "GGG"},
    {"Arginine", "CGU", "CGC", "CGA", "CGG", "AGA", "AGG"},
    {"Tyrosine", "UAU", "UAC"},
    {"Stop", "UAA", "UAG", "UGA"},
    {"Histidine", "CAU", "CAC"},
    {"Glutamine", "CAA", "CAG"},
    {"Asparagine", "AAU", "AAC"},
    {"Lysine", "AAA", "AAG"},
    {"AsparticAcid", "GAU", "GAC"},
    {"GlutamicAcid", "GAA", "GAG"},
    {"Cysteine", "UGU", "UGC"},
    {"Tryptophan", "UGG"}};


  for (int i = 0; i < DNA.length(); i++) {

    if (DNA.charAt(i) != ' ')
      compressedDNA += DNA.charAt(i);
  }


  for (int i = 0; i < compressedDNA.length(); i++)
    if (compressedDNA.charAt(i) == 'A')
      compressedmRNA += 'U';
    else if (compressedDNA.charAt(i) == 'T')
      compressedmRNA += 'A';
    else if (compressedDNA.charAt(i) == 'G')
      compressedmRNA += 'C';
    else if (compressedDNA.charAt(i) == 'C')
      compressedmRNA += 'G';

  int codonCount = compressedmRNA.length() / 3;
  String [] codonNames = new String [codonCount];
  int currentCodonInd = 0;  
  
  boolean started = false, ended = false;
  
  for (int i = 0; i < compressedmRNA.length() && !ended; i += 3) {

    String currentCodonSearched = compressedmRNA.substring(i, i + 3);
    String currentCodonName = "";
    boolean matched = false;
    //println(" searching for " + currentCodonSearched);
    
    for (int j = 0; j < 21 && !matched; j++){
      
      String currentCodonArray [] = codons[j];
      
      for(String currentComporator : currentCodonArray){
        
        //println("comparing " + currentCodonSearched + "  and  " + currentComporator);
        
        if (currentComporator.length() > 3)
          currentCodonName = currentComporator;

        else if (currentComporator.equals(currentCodonSearched))
          matched = true;
      }
    }
    
    if(!started && currentCodonName.equals("Methionine(Start)"))
      started = true;
    
    if(matched && started)
      codonNames[currentCodonInd++] = currentCodonName;
    else if(!matched)
      codonNames[currentCodonInd++] = "ERROR";
    else
      currentCodonInd++;
    
    if(started && currentCodonName.equals("Stop"))
      ended = true;
  }
  

  
  print("DNA  : ");
  for(int i = 0; i < compressedDNA.length(); i += 3)
    print(compressedDNA.substring(i, i + 3) + ' ');
  println();
  
  print("mRNA : ");
  for(int i = 0; i < compressedmRNA.length(); i += 3)
    print(compressedmRNA.substring(i, i + 3) + ' ');
  println();
  
  println("Nucleic acid chain : ");
  for(int i = 0; i < codonCount; i++)
    if(codonNames[i] != null)
      println("(" + (i + 1) + ") " + compressedmRNA.substring(i * 3, i * 3 + 3) + " - " + codonNames[i]);

}
