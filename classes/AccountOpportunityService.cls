/*
 * Apexクラスのコメント
 */
public with sharing class AccountOpportunityService {
    
    /**
     * 取引先（Account）のリストを受け取り、それぞれに紐づくデフォルトの商談（Opportunity）を作成するメソッド
     */
    public static void createDefaultOpportunities(List<Account> accounts) {
        List<Opportunity> oppsToInsert = new List<Opportunity>();
        
        for (Account acc : accounts) {
            // 取引先が新規作成された、または特定の条件を満たす場合に商談を作成
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name + ' - デフォルト商談  aa';
            opp.AccountId = acc.Id;
            opp.StageName = 'Prospecting'; // 基準フェーズ
            opp.CloseDate = Date.today().addMonths(3); // 完了予定日を3ヶ月後に設定
            
            oppsToInsert.add(opp);
        }
        
        // リストが空でない場合のみDML（挿入）を実行
        if (!oppsToInsert.isEmpty()) {
            insert oppsToInsert;
        }

        // リストが空でない場合のみDML（挿入）を実行 hamasaki
        if (!oppsToInsert.isEmpty()) {
            insert oppsToInsert;
        }
    }
}