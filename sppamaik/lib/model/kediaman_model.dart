final String tableKediaman = 'kir_kediaman';

class KediamanFields {
  static final List<String> values = [nokp, alamat, poskod, bandar];
  static const String nokp = 'nokp';
  static const String alamat = 'alamat';
  static const String poskod = 'poskod';
  static const String bandar = 'bandar';
}

class Kediaman {
  final String? nokp; //? primary key
  final String alamat;
  final String poskod;
  final String bandar;

//click kanan kt error merah tuk create constructor
  //constructor
  Kediaman({
    this.nokp,
    required this.alamat,
    required this.poskod,
    required this.bandar,
  }); //contructor

  Kediaman copy({
    String? nokp,
    String? alamat,
    String? poskod,
    String? bandar,
  }) =>
      Kediaman(
        nokp: nokp ?? this.nokp,
        alamat: alamat ?? this.alamat,
        poskod: poskod ?? this.poskod,
        bandar: bandar ?? this.bandar,
      );
  // CONVERT JSON TO MODEL
  static Kediaman fromJson(Map<String, Object?> json) => Kediaman(
        nokp: json[KediamanFields.nokp] as String?,
        alamat: json[KediamanFields.alamat] as String,
        poskod: json[KediamanFields.poskod] as String,
        bandar: json[KediamanFields.bandar] as String,
      );

  //CONVERT MODEL TO JSON
  Map<String, Object?> toJson() => {
        KediamanFields.nokp: nokp,
        KediamanFields.alamat: alamat,
        KediamanFields.poskod: poskod,
        KediamanFields.bandar: bandar,
      };
}
