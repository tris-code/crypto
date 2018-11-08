/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

extension UUID {
    /// UUID Type 4 (random)
    public init() {
        self.time = Time(.random(in: .min ... .max))
        self.clock = Clock(.random(in: .min ... .max))
        self.node = Node(.random(in: .min ... .max))
        self.version = .v4
    }
}
