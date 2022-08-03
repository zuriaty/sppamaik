final String tableKir = 'kir_master';

class KirFields {
  static final List<String> values = [nokp, nama, notelefon];
  static const String nokp = 'nokp';
  static const String nama = 'nama';
  static const String notelefon = 'notelefon';
}

class Kir {
  final String? nokp; //? primary key
  final String nama;
  final String notelefon;

//click kanan kt error merah tuk create constructor
  //constructor
  Kir({
    this.nokp,
    required this.nama,
    required this.notelefon,
  }); //contructor

  Kir copy({
    String? nokp,
    String? nama,
    String? notelefon,
  }) =>
      Kir(
        nokp: nokp ?? this.nokp,
        nama: nama ?? this.nama,
        notelefon: notelefon ?? this.notelefon,
      );
  // CONVERT JSON TO MODEL
  static Kir fromJson(Map<String, Object?> json) => Kir(
        nokp: json[KirFields.nokp] as String?,
        nama: json[KirFields.nama] as String,
        notelefon: json[KirFields.notelefon] as String,
      );

  //CONVERT MODEL TO JSON
  Map<String, Object?> toJson() => {
        KirFields.nokp: nokp,
        KirFields.nama: nama,
        KirFields.notelefon: notelefon,
      };
}
