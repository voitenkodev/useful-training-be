import * as bcrypt from 'bcryptjs';

export class Hash {
  static make(plainText) {
    const salt = bcrypt.genSaltSync();
    return bcrypt.hashSync(plainText, salt);
  }

  static compare(plainText, hash) {
    return bcrypt.compareSync(plainText, hash);
  }
}
