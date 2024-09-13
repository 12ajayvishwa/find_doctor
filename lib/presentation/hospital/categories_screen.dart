import '../../core/constants/app_export.dart';
import '../../utils/custom_toast.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.getSpecialization();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(children: [
        appBarContainer(
          size,
          title: "Categories",
          isLeading: true,
        ),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: authController.specializationList.length,
            itemBuilder: (context, index) {
              print(authController.specializationList[index].name!);
              return Card(
                surfaceTintColor: AppColors.whiteA700,
                child: ListTile(
                  title: Text(authController.specializationList[index].name!),
                  subtitle:
                      Text(authController.specializationList[index].description!),
                  leading: CustomImageView(
                    url: authController.specializationList[index].icon,
                  ),
                  
                ),
              );
            },
          );
        })
      ]),
    ));
  }
}
