
package com.hellocat.vo;


import helloCat_MVC.Join;
import helloCat_MVC.Join_insert;
import helloCat_MVC.Letter;
import helloCat_MVC.Login;
import helloCat_MVC.Login_check;
import helloCat_MVC.NickNameCheck;
import helloCat_MVC.PhoneCheck;
import helloCat_MVC.Board_Main;
import helloCat_MVC.ClickInfinite;
import helloCat_MVC.EmailCheck;
import helloCat_MVC.IdCheck;
import helloCat_MVC.Insert_letter_comment;
import helloCat_MVC.Insert_like;
import helloCat_MVC.Insert_photo_comment;
import helloCat_MVC.Photo;
import helloCat_MVC.Search;
import helloCat_MVC.ShowLetter;
import helloCat_MVC.WriteLetter;
import helloCat_MVC.WritePhoto;
import helloCat_MVC.delete_like;

public class ActionFactory {
	private static final ActionFactory instance = new ActionFactory();
	private ActionFactory() { }
	static ActionFactory getInstance() {
		return instance;
	}
	Action getAction(String command) {
		Action action = null;
		switch(command) {
		case "storemain":
			action = new StoreMainAction();
			break;
		case "storetoy":
			action = new StoreToyAction();
			break;
		case "storetoy_n":
			action = new StoreToyAction_n();
			break;
		case "storegoods":
			action = new StoreGoodsAction();
			break;
		case "storegoods_n":
			action = new StoreGoodsAction_n();
			break;
		case "storefood":
			action = new StoreFoodAction();
			break;
		case "storefood_n":
			action = new StoreFoodAction_n();
			break;
		case "showOnePd":
			action = new ShowOnePd();
			break;
		case "insertToCart":
			action = new InsertToCart();
			break;
		case "deleteFromCart":
			action = new DeleteFromCartAction();
			break;
		case "showcart":
			action = new ShowCart();
			break;
		case "buyProduct":
			action = new BuyProductAction();
			break;
		case "memberForPurchase":
			action = new MemberForPurchase();
			break;
		case "afterPurchase":
			action = new AfterPurchase();
			break;
		case "showReview":
			action = new ShowReview(); 
			break;
		case "writeReview":
			action = new WriteReviewAction();
			break;
		case "insertReview":
			action = new InsertReviewAction();
			break;
		case "infiniteScroll_g":
			action = new InfiniteScroll_G();
			break;
		case "infiniteScroll_g_n":
			action = new InfiniteScroll_G_n();
			break;
		case "infiniteScroll_f":
			action = new InfiniteScroll_F();
			break;
		case "infiniteScroll_f_n":
			action = new InfiniteScroll_F_n();
			break;
		case "infiniteScroll_t":
			action = new InfiniteScroll_T();
			break;
		case "infiniteScroll_t_n":
			action = new InfiniteScroll_T_n();
			break;
		case "Board_Main" :
			action = new Board_Main();
			break;
		case "Letter" :
			action = new Letter();
			break;
		case "Photo" :
			action = new Photo();
			break;
		case "Insert_photo_comment" :
			action = new Insert_photo_comment();
			break;
		case "Insert_letter_comment" :
			action = new Insert_letter_comment();
			break;
		case "Login_check" :
			action = new Login_check();
			break;
		case "Login" :
			action = new Login();
			break;
		case "Join" :
			action = new Join();
			break;
		case "IdCheck" :
			action = new IdCheck();
			break;
		case "NickNameCheck" :
			action = new NickNameCheck();
			break;
		case "EmailCheck" :
			action = new EmailCheck();
			break;
		case "PhoneCheck" :
			action = new PhoneCheck();
			break;
		case "Join_insert" :
			action = new Join_insert();
			break;
		case "Search" :
			action = new Search();
			break;
		case "ShowLetter" :
			action = new ShowLetter();
			break;
		case "ClickInfinite" :
			action = new ClickInfinite();
			break;
		case "Insert_like" :
			action = new Insert_like();
			break;
		case "WritePhoto" :
			action = new WritePhoto();
			break;
		case "WriteLetter" :
			action = new WriteLetter();
			break;
		case "delete_like" :
			action = new delete_like();
			break;
		}
		return action;
	}
}
