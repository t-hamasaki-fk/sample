@isTest
private class AccountOpportunityServiceTest {

    @isTest
    static void testCreateDefaultOpportunities() {
        // 1. テストデータの準備
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'テスト取引先 ' + i));
        }
        insert testAccounts; // 取引先をデータベースに挿入（Idが発番される）
        
        // 2. テスト対象メソッドの実行
        // ガバナ制限（ガバナカウンタ）をリセットし、非同期処理などもここで同期化させる
        Test.startTest();
        AccountOpportunityService.createDefaultOpportunities(testAccounts);
        Test.stopTest();
        
        // 3. 結果の検証（アサーション）
        // 作成された商談の数を検証
        List<Opportunity> createdOpps = [SELECT Id, Name, AccountId, StageName FROM Opportunity WHERE AccountId IN :testAccounts];
        System.assertEquals(5, createdOpps.size(), '5件の取引先に対して5件の商談が作成されている必要があります。');
        
        // データの内容が正しいか検証
        for (Opportunity opp : createdOpps) {
            System.assertEquals('Prospecting', opp.StageName, '商談のフェーズは Prospecting である必要があります。');
            System.assert(opp.Name.contains('デフォルト商談'), '商談名に正しい接尾辞が含まれている必要があります。');
        }
    }
}